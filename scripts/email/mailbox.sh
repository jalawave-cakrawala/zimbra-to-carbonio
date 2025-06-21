echo "Memulai backup mailbox..."

mkdir -p $PROJECT/emails/mailbox
ssh $SSH_ACCOUNT mkdir -p $REMOTE_DIR/emails/mailbox

for email in $(cat $PROJECT/emails/names.txt); do
  if [[ -n "$MAILBOX_FIRST_DATE" ]]; then
    first_raw_date=$MAILBOX_FIRST_DATE
  else
    first_raw_date=$(zmmailbox -z -m $email s -t message -s dateAsc -l 1 "is:anywhere" | awk 'NF>=2 && NR>4 {print $(NF-1)}')
  fi

  if [[ -n "$MAILBOX_LAST_DATE" ]]; then
    last_raw_date=$MAILBOX_LAST_DATE
  else
    last_raw_date=$(zmmailbox -z -m $email s -t message -s dateDesc -l 1 "is:anywhere" | awk 'NF>=2 && NR>4 {print $(NF-1)}')
  fi

  first_month=$(date -d $first_raw_date +%m/01/%y)
  offset=$(date -d $first_month +%m/01/%y)
  last_month=$(date -d "$last_raw_date + 1 month" +%m/01/%y)
  today_month=$(date +%m/01/%y)

  if [[ "$first_month" != "$today_month" ]]; then
    ssh $SSH_ACCOUNT mkdir -p $REMOTE_DIR/emails/mailbox/$email

    while [ "$offset" != "$last_month" ]; do
      after=$(date -d "$offset - 1 day" +%m/%d/%y)
      before=$(date -d "$offset + 1 month" +%m/%d/%y)

      formatted_date=$(date -d $offset +%Y-%m)

      echo -ne "\rmemulai backup mailbox $email bulan $formatted_date\033[K"

      zmmailbox -z -m "$email" -t 0 getRestURL "/?fmt=tgz&query=before:$before after:$after" >$PROJECT/emails/mailbox/$email-$formatted_date.tgz || {
        echo -ne "\r\033[K"
        rm -rf $PROJECT/emails/mailbox/$email-$formatted_date.tgz
        offset=$(date -d "$offset + 1 month" +%m/01/%y)
        continue
      }
      rsync --remove-source-files $PROJECT/emails/mailbox/$email-$formatted_date.tgz $SSH_ACCOUNT:$REMOTE_DIR/emails/mailbox/$email/$email-$formatted_date.tgz

      offset=$(date -d "$offset + 1 month" +%m/01/%y)

      echo -ne "\r\033[K"
      echo "✅ Selesai."
    done
  fi
done
