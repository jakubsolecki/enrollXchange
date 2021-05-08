from django.core.mail import send_mail as django_send_mail

import enrollXchange.settings as settings


def send_mail(subject, message, recipient, from_mail=settings.DEFAULT_FROM_EMAIL):
    if not isinstance(recipient, list):
        recipient = [recipient]
    django_send_mail(
        subject=subject,
        message=message,
        from_email=from_mail,
        recipient_list=recipient,
        fail_silently=settings.EMAIL_FAIL_SILENTLY,
    )


def send_offer_accepted(
    offer_client_mail, offer_owner_mail, offer_class_time: str, client_class_time: str
):
    send_mail(
        subject="You've accepted the offer",
        message=f"""
You've accepted {offer_class_time}
for {client_class_time}
""",
        recipient=offer_client_mail,
    )
    send_mail(
        subject="Your offer's been accepted",
        message=f"""
Your offer {offer_class_time}'s been accepted
for {client_class_time}
""",
        recipient=offer_owner_mail,
    )
