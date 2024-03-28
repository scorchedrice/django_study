from django.db import models

# Create your models here.
class CRUDS(models.Model):
    title = models.CharField(max_length=10)
    content = models.CharField(max_length=100)
