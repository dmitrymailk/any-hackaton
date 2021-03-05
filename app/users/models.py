from django.dispatch import receiver
from django.db.models.signals import post_save
from django.contrib.auth.models import AbstractUser
from django.db import models
from django.contrib.postgres.fields import ArrayField
from datetime import datetime


class CustomUser(AbstractUser):
    pass

    def __int__(self):
        return self.id