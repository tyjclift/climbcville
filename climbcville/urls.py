# Urls is going to keep track of all of the HTML templates that you navigate to 
# when you click on a button or interact with the application in some way. 

from django.urls import path

from . import views

app_name = 'climbcville'
urlpatterns = [
    # ex: /climbcville/
    path('', views.index, name='index'),

    # ex: /climbcville/fav_poll_q5/
    path('fav_poll_q'+'<int:question_id>/', views.detail, name='detail'),
    # ex: /climbcville/fav_poll_q5/results
    path('fav_poll_q'+'<int:question_id>/results/', views.results, name='results'),
    # ex: /climbcville/fav_poll_q5/empty_result
    path('fav_poll_q'+'<int:question_id>/empty_result/', views.vote, name='vote'),

    path('location/', views.location, name='location'),

    # ex: /climbcville/log_entry_form
    path('location<int:location_id>/'+'route_entry_form/', views.route_entry_form, name='route_entry_form'),

    
]
