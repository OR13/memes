echo 
echo "Installing ✨ "$1
echo 

DID_MEME=$1
curl -s https://didme.me/api/$DID_MEME | jq '.' > parent.json
ID=$(cat ./parent.json | jq -r '.didDocument.id | split(":")[2]')
USERNAME=$(gh repo view --json url | jq -r  '.url | split("/")[3]' | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/")
DID_WEB="did:web:$USERNAME.github.io:memes:$ID"
mkdir -p ./docs/memes/$ID
mv ./parent.json ./docs/memes/$ID/parent.json
cat ./docs/memes/$ID/parent.json | jq '.didDocument' | sed "s/$DID_MEME/$DID_WEB/g"  > ./docs/memes/$ID/did.json
git add ./docs
git commit -m ":rocket:"
git push origin main
echo
echo "Say goodbye to 🔥 $DID_MEME"
echo
echo "Say hello to  🌴 $DID_WEB"
echo
echo "Follow these instructions https://or13.github.io/didme.me/#using-github-pages"
echo
echo "After deployment succeeds click this link:"
echo
echo "https://didme.me/$DID_WEB"