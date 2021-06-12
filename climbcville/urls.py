# Urls is going to keep track of all of the HTML templates that you navigate to 
# when you click on a button or interact with the application in some way. 

from django.urls import path

from . import views

app_name = 'climbcville'
urlpatterns = [
    # ex: /climbcville/
    path('', views.index, name='index'),
    # ex: /climbcville/5/
    path('<int:question_id>/', views.detail, name='detail'),
    # ex: /climbcville/5/results/
    path('<int:question_id>/results/', views.results, name='results'),
    # ex: /climbcville/5/vote/
    path('<int:question_id>/vote/', views.vote, name='vote'),
    # ex: /climbcville/log_entry_form
    path('log_entry/', views.route_entry_form, name='log_entry')
]
