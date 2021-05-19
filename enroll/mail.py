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
for {client_class_time}.
""",
        recipient=offer_client_mail,
    )
    send_mail(
        subject="Your offer's been accepted",
        message=f"""
Your offer {offer_class_time}'s been accepted
for {client_class_time}.
""",
        recipient=offer_owner_mail,
    )


def send_request_accepted(
    student_mail,
    lecturer_mail,
    class_time: str,
    former_class_time: str,
    comment: str,
    name: str,
):
    send_mail(
        subject="Your request's been accepted",
        message=f"""
Your request {class_time}'s been accepted
formerly {former_class_time}.
""",
        recipient=student_mail,
    )
    send_mail(
        subject="You've accepted the request",
        message=f"""
You've accepted {name}'s request to join
the your {class_time} group
due to {comment}.
""",
        recipient=lecturer_mail,
    )
