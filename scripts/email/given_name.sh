echo "Memulai backup email given name..."

mkdir -p $PROJECT/emails/given_name
ssh $SSH_ACCOUNT mkdir -p $REMOTE_DIR/emails/given_name

for name in $(cat $PROJECT/emails/names.txt); do
  echo -ne "\r- backup given name $name...\033[K "

  zmprov -l ga $name givenName | grep givenName: | awk -F'givenName:[[:space:]]*' '/^givenName:/ { print $2 }' >$PROJECT/emails/given_name/$name.txt
  rsync --remove-source-files $PROJECT/emails/given_name/$name.txt $SSH_ACCOUNT:$REMOTE_DIR/emails/given_name/$name.txt

  echo "✅ Selesai."
done
