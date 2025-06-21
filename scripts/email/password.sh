echo "Memulai backup email password..."

mkdir -p $PROJECT/emails/password
ssh $SSH_ACCOUNT mkdir -p $REMOTE_DIR/emails/password

for name in $(cat $PROJECT/emails/names.txt); do
  echo -ne "\r- backup password email $name...\033[K "

  zmprov -l ga $name userPassword | grep userPassword: | awk '{ print $2}' >$PROJECT/emails/password/$name.shadow
  rsync --remove-source-files $PROJECT/emails/password/$name.shadow $SSH_ACCOUNT:$REMOTE_DIR/emails/password/$name.shadow

  echo "✅ Selesai."
done
