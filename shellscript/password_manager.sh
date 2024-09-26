#!/bin/bash

echo "パスワードマネージャーへようこそ！"

AddPassword="Add Password"
GetPassword="Get Password"
Exit="Exit" 

selecter() {
  echo "次の選択肢から入力してください（Add Password/Get Password/Exit):"
  read option
}  

while true
do
  selecter
        
        #Add Passwordが入力された場合
        if [ "$option" = "$AddPassword" ]; then
            echo "サービス名を入力してください："
            read service

            echo "ユーザー名を入力してください："
            read username

            echo "パスワード入力してください："
            read password

            echo "パスワードの追加は成功しました。"

            echo "$service:$username:$password" >> password_manager.txt
        
        #Get Passwordが入力された場合
        elif [ "$option" = "$GetPassword" ]; then
          echo "サービス名を入力してください："
          read service

          if grep -q "^$service:" password_manager.txt; then
              grep "^$service:" password_manager.txt | while IFS=':' read -r found_service found_username found_password; do
                  echo "サービス名：$found_service"
                  echo "ユーザー名：$found_username"
                  echo "パスワード：$found_password"
              done 
              
          else 
            echo "そのサービスは登録されていません。"
          fi

        elif [ "$option" = "$Exit" ]; then
           #Exitが入力された場合
           echo "Thank you!"
           exit 0

        else 
          echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
        fi
done