import datetime

from django.db import models
from django.utils import timezone

class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField('date published')
    def __str__(self):
        return self.question_text
    def was_published_recently(self):
        return self.pub_date >= timezone.now() - datetime.timedelta(days=1)

class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)
    def __str__(self):
        return self.choice_text

class Person(models.Model):
    person_id = models.IntegerField(primary_key=True)
    f_name = models.CharField(max_length=50)
    l_name = models.CharField(max_length=50)
    email = models.EmailField(max_length=50)
    phone = models.IntegerField()
    def __str__(self):
        return (str)(self.person_id)

    # see abstract base classes, meta inheritance
    class Meta:
        abstract = True
    

class Route_Setter(Person):
    rs_experience_level = models.PositiveIntegerField() # quantitative for now
    certifications = models.TextField() # comma separated? or create separate table for certifications?

class Climber(Person):
    c_experience_level = models.PositiveIntegerField() # quantitative for now
    routes_attempted = models.PositiveIntegerField()
    is_team_member = models.BooleanField()

class Admin(Person):
    is_owner = models.BooleanField()
    edit_permission = models.BooleanField()
    create_permission = models.BooleanField()
    delete_permission = models.BooleanField()

class Location(models.Model):
    location_id = models.IntegerField(primary_key=True)
    latitude = models.FloatField()
    longitude = models.FloatField()
    approach_info = models.TextField()
    location_name = models.CharField(max_length=100, null=True)

class Route(models.Model):
    route_id = models.IntegerField(primary_key=True)
    route_name = models.CharField(max_length=100)
    r_type = models.CharField(max_length=20) # ideally we would make this multiple choice - either by assigning integers or booleans
    rs_grade = models.CharField(max_length=10)
    location_id = models.ForeignKey(Location, on_delete=models.CASCADE, null=True)
    person_id = models.ManyToManyField(Route_Setter)

class Route_Log_Entry(models.Model):
    entry_id = models.IntegerField(primary_key=True)
    comment = models.TextField()
    beta = models.TextField()
    c_grade = models.CharField(max_length=10)
    c_rating = models.CharField(max_length=10)
    c_id = models.ForeignKey(Climber, on_delete=models.CASCADE, null=True)
    route_id = models.ForeignKey(Route, on_delete=models.CASCADE, null=True)