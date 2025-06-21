dir_chunks=$dir_domains/chunks

echo -ne "\rMemulai backup domain name...\033[K "

mkdir -p $PROJECT/domains
ssh $SSH_ACCOUNT mkdir -p $REMOTE_DIR/domains

rm -rf $PROJECT/domains/names.txt
zmprov -l gad >$PROJECT/domains/names.txt

rsync $PROJECT/domains/names.txt $SSH_ACCOUNT:$REMOTE_DIR/domains/

echo "✅ Selesai."
