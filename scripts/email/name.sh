echo -ne "\rMemulai backup email name...\033[K "

mkdir -p $PROJECT/emails
ssh $SSH_ACCOUNT mkdir -p $REMOTE_DIR/emails

rm -rf $PROJECT/emails/names.txt

zmprov -l gaa >$PROJECT/emails/names.txt
rsync $PROJECT/emails/names.txt $SSH_ACCOUNT:$REMOTE_DIR/emails/

echo "✅ Selesai."
