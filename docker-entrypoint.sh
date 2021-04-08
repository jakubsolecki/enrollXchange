if [ "$ENVIRONMENT" = "local" ]; then
  echo "Running locally"
fi
python manage.py migrate
( cd frontend ; yarn install )
if [ "$ENVIRONMENT" = "local" ]; then
  (cd frontend ; yarn dev ) &
else
  ( cd frontend ; yarn build )
fi
if [ "$ENVIRONMENT" = "local" ]; then
#  gunicorn -b 0.0.0.0:8000 enrollXchange.wsgi --reload --log-level "${GUNICORN_LOG_LEVEL}" &
  python manage.py runserver 0.0.0.0:8000 &
  python manage.py livereload
else
  python manage.py collectstatic --noinput
  gunicorn enrollXchange.wsgi
fi
