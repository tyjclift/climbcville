# HTML templates pull from the view. Make changes to models in the view 
# put all of the variables into context. Context is dictionary of objects 
# that you will need to access in the HTML template. 

from django.http import HttpResponse, HttpResponseRedirect, response
from django.shortcuts import get_object_or_404, render
from django.urls import reverse
from django.contrib import messages

from .models import Choice, Location, Question, Route, User_Input, Route_Setter
from .forms import Route_Log_Entry_Form

# Render out the location dropdown and poll dropdowns 
def index(request):
    latest_question_list = Question.objects.order_by('-pub_date')[:5]
    locations_list = Location.objects.all
    routes_list = Route.objects.all
    context = {'latest_question_list': latest_question_list, 
               'showlocations': locations_list,
               'routes_list': routes_list}
    return render(request, 'climbcville/index.html', context)

def poll_details(request, question_id):
    # The HTML template we made to render the intitial question will have a field of 
    question = get_object_or_404(Question, pk=question_id)
    return render(request, 'climbcville/poll_details.html', {'question': question})

def detail(request, question_id):
    # The HTML template we made to render the intitial question will have a field of 
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
    # Get the question object datasource of a particular question id 
    question = get_object_or_404(Question, pk=question_id)
    try:
        # Further subset the question datasource by getting the row corresponding to 
        # the choice that the user has made 
        selected_choice = question.choice_set.get(pk=request.POST.get('choice'))
    except (KeyError, Choice.DoesNotExist):
        # Redisplay the question voting form IN the event the user did not enter data yet
        return render(request, 'climbcville/detail.html', {
            'question': question,
            'error_message': "You didn't select a choice.",
        })
    else:
        # Update the row in the question dataframe based on how the user voted 
        selected_choice.votes += 1
        # Save the results of the users vote to the database 
        selected_choice.save()
        # Always return an HttpResponseRedirect after successfully dealing
        # with POST data. This prevents data from being posted twice if a
        # user hits the Back button.
        return HttpResponseRedirect(reverse('climbcville:results', args=(question.id,)))


# Render out the route entry form 
def route_entry_form(request, location_id):

    if request.POST.get('route_choice') != None:
        print('input:',request.POST.get('route_choice'))
        route_objs = get_object_or_404(Route, pk=int(request.POST.get('route_choice')))
        input = User_Input(user_code=1, location_id=location_id, route_id=route_objs.route_id)
        input.save()
    form = Route_Log_Entry_Form()
    context = {'form':form}
    context['location_choice'] = get_object_or_404(Location, pk=int(location_id))
    data_input = get_object_or_404(User_Input, pk=1)
    context['route_choice'] = get_object_or_404(Route,pk=int(data_input.route_id))

    # If the request method is post
    if request.method == 'POST':
        # Get the information from the user input 
        form = Route_Log_Entry_Form(request.POST)
        # Check if all attributes are correct
        if form.is_valid():
            # Update route id to match previous pages
            form = form.save(commit=False)
            form.route_id = get_object_or_404(Route, pk=int(data_input.route_id))
            # Save to our data
            form.save()
    # Return the context information request to a particular html site 
    return render(request, "climbcville/route_entry_form.html", context)


# Render out the locations page with a list of routes and other location 
# information added to it 
def location(request):
    # Get the user selection of location 
    choice = request.POST.get('location_choice')
    location_objs = get_object_or_404(Location, pk=choice)
    context = {'location_objs':location_objs}
    context['route_objs'] = Route.objects.filter(location_id_id=int(choice))

    # Update the user information when the user interacts with system 
    input = User_Input(user_code=1, location_id=location_objs.location_id)
    input.save()
    return render(request, "climbcville/location.html", context)