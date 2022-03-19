from django.conf import settings
from rest_framework import serializers

class UserModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = settings.AUTH_USER_MODEL
        fields = '__all__'