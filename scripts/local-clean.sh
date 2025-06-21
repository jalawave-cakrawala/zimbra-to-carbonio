echo -ne "\rMenghapus file lokal...\033[K "

rm -rf $PROJECT/distribution_lists/*
rm -rf $PROJECT/domains/*
rm -rf $PROJECT/emails/*

echo "✅ Selesai."
