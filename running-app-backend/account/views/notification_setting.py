from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from account.models import NotificationSetting
from account.serializers import NotificationSettingSerializer

class NotificationSettingViewSet(viewsets.ModelViewSet):
    queryset = NotificationSetting.objects.all()
    serializer_class = NotificationSettingSerializer
    # permission_classes = [IsAuthenticated]

    # def get_queryset(self):
    #     return self.queryset.filter(user=self.request.user)

    # def perform_create(self, serializer):
    #     serializer.save(user=self.request.user)