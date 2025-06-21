echo "Memulai backup distribution list forwarding address..."

mkdir -p $PROJECT/distribution_lists/forwarding_address
ssh $SSH_ACCOUNT mkdir -p $REMOTE_DIR/distribution_lists/forwarding_address

for name in $(cat $PROJECT/distribution_lists/names.txt); do
  echo -ne "\r- backup forwarding address distribution list $name...\033[K "

  zmprov -l gdl $name zimbraMailForwardingAddress | grep zimbraMailForwardingAddress: | awk '{print $2}' >$PROJECT/distribution_lists/forwarding_address/$name.txt
  rsync --remove-source-files $PROJECT/distribution_lists/forwarding_address/$name.txt $SSH_ACCOUNT:$REMOTE_DIR/distribution_lists/forwarding_address/$name.txt

  echo "✅ Selesai."
done
