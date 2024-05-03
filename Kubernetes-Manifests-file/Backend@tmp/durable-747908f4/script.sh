
                        git config user.email "deepnabha20@gmail.com"
                        git config user.name "Pardeep32"
                        BUILD_NUMBER=${BUILD_NUMBER}
                        echo $BUILD_NUMBER
                        imageTag=$(grep -oP '(?<=backend:)[^ ]+' deployment.yaml)
                        echo $imageTag
                        untracked_files=$(git ls-files --others --exclude-standard)
                        if [ -z "$untracked_files" ]; then
                            sed -i "s|${AWS_ECR_REPO_NAME}:${imageTag}|${AWS_ECR_REPO_NAME}:${BUILD_NUMBER}|" deployment.yaml
                            git add deployment.yaml
                            git add ../../Application-Code/backend/.scannerwork/
                            git add ../../Application-Code/backend/dependency-check-report.xml
                            git add ../../Application-Code/backend/trivyfs.txt
                            git add ../Backend@tmp/
                            git add ../../trivyimage.txt
                            git commit -m "Update deployment Image to version ${BUILD_NUMBER}"
                            git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:master
                        else
                            echo "Untracked files present. Aborting Git operations."
                        fi
                    