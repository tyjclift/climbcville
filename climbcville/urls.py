from django.urls import path

from . import views

app_name = 'climbcville'
urlpatterns = [
    # ex: /climbcville/
    path('', views.index, name='index'),
    # ex: /climbcville/question5/
    path('question<int:question_id>/', views.poll_details, name='poll_details'),
    # ex: /climbcville/route5/
    path('route<int:route_id>/', views.route_details, name='route_details'),
    # ex: /climbcville/question5/results/
    path('question<int:question_id>/results/', views.results, name='results'),
    # ex: /climbcville/question5/vote/
    path('question<int:question_id>/vote/', views.vote, name='vote'),
]
