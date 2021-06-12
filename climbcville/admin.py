from django.contrib import admin

from .models import Question, Choice, Climber, Route_Setter, Admin, Route, Route_Log_Entry, Location

admin.site.register(Question)
admin.site.register(Choice)
admin.site.register(Climber)
admin.site.register(Route_Setter)
admin.site.register(Admin)
admin.site.register(Route)
admin.site.register(Route_Log_Entry)
admin.site.register(Location)
