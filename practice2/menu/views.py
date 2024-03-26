from django.shortcuts import render

import random
# Create your views here.
def index(request):
    foods = ['국밥','국수','카레','탕수육',]
    picked = random.choice(foods)
    context = {
        'foods':foods,
        'picked':picked,
    }
    return render(request,'index.html',context)