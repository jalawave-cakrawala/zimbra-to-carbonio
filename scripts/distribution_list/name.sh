echo -ne "\rMemulai backup distribution list name...\033[K "

mkdir -p $PROJECT/distribution_lists
ssh $SSH_ACCOUNT mkdir -p $REMOTE_DIR/distribution_lists

rm -rf $PROJECT/distribution_lists/names.txt
zmprov -l gadl >$PROJECT/distribution_lists/names.txt

rsync $PROJECT/distribution_lists/names.txt $SSH_ACCOUNT:$REMOTE_DIR/distribution_lists/

echo "✅ Selesai."
