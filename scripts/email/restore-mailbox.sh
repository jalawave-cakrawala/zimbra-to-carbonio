echo "Memulai restore mailbox..."

for email in $(cat $PROJECT/emails/names.txt); do
  for mail in $PROJECT/emails/mailbox/$email/*; do
    echo -ne "\r- memulai restore $email = $mail...\033[K "
    zmmailbox -z -m $email -t 0 postRestURL "/?fmt=tgz&resolve=skip" $PROJECT/emails/mailbox/$email/$mail

    echo "✅ Selesai."
  done
done
