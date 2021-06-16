# Urls is going to keep track of all of the HTML templates that you navigate to 
# when you click on a button or interact with the application in some way. 

from django.urls import path

from . import views

app_name = 'climbcville'
urlpatterns = [
    # ex: /climbcville/
    path('', views.index, name='index'),

    path('location/', views.location, name='location'),

    # ex: /climbcville/log_entry_form
    path('location<int:location_id>/'+'route_entry_form/', views.route_entry_form, name='route_entry_form'),

    
    # ex: /climbcville/question5/
    path('question<int:question_id>/', views.poll_details, name='poll_details'),
    # ex: /climbcville/question5/results/
    path('question<int:question_id>/results/', views.results, name='results'),
    # ex: /climbcville/question5/vote/
    path('question<int:question_id>/vote/', views.vote, name='vote'),
]
