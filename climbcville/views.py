from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import get_object_or_404, render
from django.urls import reverse

from .models import Choice, Question, Route, Route_Setter, Location


def index(request):
    latest_question_list = Question.objects.order_by('-pub_date')[:5]
    routes_list = Route.objects.order_by('rs_grade')[:1000] # no more than 1000 routes will display
    context = {'latest_question_list': latest_question_list, 'routes_list': routes_list}
    return render(request, 'climbcville/index.html', context)

def poll_details(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    return render(request, 'climbcville/poll_details.html', {'question': question})

def route_details(request, route_id):
    route = get_object_or_404(Route, pk=route_id)
    location = get_object_or_404(Location, pk=route.location_id.location_id)
    context = {'route': route, 'location': location}
    return render(request, 'climbcville/route_details.html', context)

def results(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    return render(request, 'climbcville/results.html', {'question': question})

def vote(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    try:
        selected_choice = question.choice_set.get(pk=request.POST['choice'])
    except (KeyError, Choice.DoesNotExist):
        # Redisplay the question voting form.
        return render(request, 'climbcville/poll_details.html', {
            'question': question,
            'error_message': "You didn't select a choice.",
        })
    else:
        selected_choice.votes += 1
        selected_choice.save()
        # Always return an HttpResponseRedirect after successfully dealing
        # with POST data. This prevents data from being posted twice if a
        # user hits the Back button.
        return HttpResponseRedirect(reverse('climbcville:results', args=(question.id,)))

