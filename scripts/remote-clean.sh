echo -ne "\rMenghapus file remote...\033[K "

ssh $SSH_ACCOUNT mkdir -p $REMOTE_DIR
ssh $SSH_ACCOUNT rm -rf $REMOTE_DIR/*

echo "✅ Selesai."
