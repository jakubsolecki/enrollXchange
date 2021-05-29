if [ "$ENVIRONMENT" = "local" ]; then
  echo "Running locally"
fi
python manage.py migrate
if [ "$ENVIRONMENT" = "local" ]; then
  ( cd frontend ; yarn install ; yarn dev ) &
  python manage.py runserver 0.0.0.0:8000 &
  python manage.py livereload
else
  python manage.py collectstatic --noinput
  gunicorn enrollXchange.wsgi
fi
