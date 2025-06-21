echo "Memulai backup email display name..."

mkdir -p $PROJECT/emails/display_name
ssh $SSH_ACCOUNT mkdir -p $REMOTE_DIR/emails/display_name

for name in $(cat $PROJECT/emails/names.txt); do
  echo -ne "\r- backup display name $name...\033[K "

  zmprov -l ga $name displayName | grep displayName: | awk -F'displayName:[[:space:]]*' '/^displayName:/ { print $2 }' >$PROJECT/emails/display_name/$name.txt
  rsync --remove-source-files $PROJECT/emails/display_name/$name.txt $SSH_ACCOUNT:$REMOTE_DIR/emails/display_name/$name.txt

  echo "✅ Selesai."
done
