from django.forms import ModelForm
from .models import Route_Log_Entry

# Create the route log entry form 
class Route_Log_Entry_Form(ModelForm):
    class Meta: 
        model = Route_Log_Entry
        fields = ['comment','beta','c_grade','c_rating','c_id','route_id']



