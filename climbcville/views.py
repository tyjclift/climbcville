# HTML templates pull from the view. Make changes to models in the view 
# put all of the variables into context. Context is dictionary of objects 
# that you will need to access in the HTML template. 

from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import get_object_or_404, render
from django.urls import reverse

from .models import Choice, Question
from .forms import Route_Log_Entry_Form

def index(request):
    # Get the first 5 elements in the initial list of questions about which poll you want to answer
    #  from the cville_question datatable 
    latest_question_list = Question.objects.order_by('-pub_date')[:5]
    # Render the list of questions to be passed into index.html
    context = {'latest_question_list': latest_question_list}
    return render(request, 'climbcville/index.html', context)

def detail(request, question_id):
    # The HTML template we made to render the intitial question will have a field of 
    question = get_object_or_404(Question, pk=question_id)
    return render(request, 'climbcville/detail.html', {'question': question})

def results(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    return render(request, 'climbcville/results.html', {'question': question})

def vote(request, question_id):
    # Get the question object datasource of a particular question id 
    question = get_object_or_404(Question, pk=question_id)
    try:
        # Further subset the question datasource by getting the row corresponding to 
        # the choice that the user has made 
        selected_choice = question.choice_set.get(pk=request.POST['choice'])
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
def route_entry_form(request):
    # Get access to the route log entry data 
    form = Route_Log_Entry_Form()
    # If the request method is post
    if request.method == 'POST':
        # Get the information from the user input 
        form = Route_Log_Entry_Form(request.POST)
        # Check if all attributes are correct
        if form.is_valid:
            # Save to our data
            form.save()
    context = {'form':form}
    # Return the context information request to a particular html site 
    return render(request, "climbcville/log_entry_form.html", context)