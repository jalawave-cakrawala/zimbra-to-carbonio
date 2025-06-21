echo "Memulai backup email status..."

mkdir -p $PROJECT/emails/status
ssh $SSH_ACCOUNT mkdir -p $REMOTE_DIR/emails/status

for name in $(cat $PROJECT/emails/names.txt); do
  echo -ne "\r- backup status email $name...\033[K "

  zmprov -l ga $name zimbraAccountStatus | grep zimbraAccountStatus: | awk '{ print $2 }' >$PROJECT/emails/status/$name.txt
  rsync --remove-source-files $PROJECT/emails/status/$name.txt $SSH_ACCOUNT:$REMOTE_DIR/emails/status/$name.txt

  echo "✅ Selesai."
done
