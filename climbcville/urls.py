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
]
