echo "Memulai backup domain status..."

mkdir -p $PROJECT/domains/status
ssh $SSH_ACCOUNT mkdir -p $REMOTE_DIR/domains/status

for name in $(cat $PROJECT/domains/names.txt); do
  echo -ne "\r- backup status domain $name...\033[K "

  zmprov gd $name zimbraDomainStatus | grep zimbraDomainStatus: | awk '{print $2}' >$PROJECT/domains/status/$name.txt
  rsync --remove-source-files $PROJECT/domains/status/$name.txt $SSH_ACCOUNT:$REMOTE_DIR/domains/status/$name.txt

  echo "✅ Selesai."
done
