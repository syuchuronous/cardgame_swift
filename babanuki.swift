/*4人対戦(自分とコンピュータ×3)のババ抜き*/

//自分の持つトランプの表示設定
func print_mycard(tranpu:[[Int]],card:inout[[String]],myturn:Int){
    for j in 0...(tranpu[myturn].count-1){
        switch(tranpu[myturn][j]){
            case 1  : card[myturn][j]="A"; break        //「A」と表示させるよう設定
            case 2  : card[myturn][j]="2"; break        //「2」と表示させるよう設定
            case 3  : card[myturn][j]="3"; break        //「3」と表示させるよう設定
            case 4  : card[myturn][j]="4"; break        //「4」と表示させるよう設定
            case 5  : card[myturn][j]="5"; break        //「5」と表示させるよう設定
            case 6  : card[myturn][j]="6"; break        //「6」と表示させるよう設定
            case 7  : card[myturn][j]="7"; break        //「7」と表示させるよう設定
            case 8  : card[myturn][j]="8"; break        //「8」と表示させるよう設定
            case 9  : card[myturn][j]="9"; break        //「9」と表示させるよう設定
            case 10 : card[myturn][j]="10"; break       //「10」と表示させるよう設定
            case 11 : card[myturn][j]="Jack"; break     //「Jack」と表示させるよう設定
            case 12 : card[myturn][j]="Queen"; break    //「Queen」と表示させるよう設定
            case 13 : card[myturn][j]="King"; break     //「King」と表示させるよう設定
            case 0  : card[myturn][j]="Joker"; break    //「Joker」と表示させるよう設定
            default : break
        }
    }
}

//それぞれのプレイヤーが持つトランプの表示
func print_card(tranpu:[[Int]],card:inout[[String]],myturn: Int,player:[String]){
    for i in 0...3{
        if(i==myturn){                                                  //自分のターンの場合
            if(tranpu[i][0]==99){
                card[i][0]="上がり"                                     //手札がないことを示す
            }else{
                print_mycard(tranpu:tranpu,card:&card,myturn:myturn)  //表示させるトランプの設定
            }
            print(" Me ",card[i])                                       //トランプの表示
        }else{                                                          //コンピュータのターンの場合
            if(tranpu[i][0]==99){
                card[i][0]="上がり"                                     //手札がないことを示す
            }
            print(player[i],card[i])                                    //トランプの表示
        }
    }
    print("\n")
}

func my_get(Get:inout Int,tranpu:[[Int]],n:Int,player:[String]){
    if(tranpu[n].count==1){
        //コンピュータの持つ最後の1枚の手札を入手
        print("あなたの番です。1を入力して",player[n],"の手札を引いてください。")
        Get=Int(readLine()!)!
        while(Get != 1){
            print( "1を入力してください")
            Get=Int(readLine()!)!
        }
    }else{
        //コンピュータの持つ手札の中から1枚入手
        print("あなたの番です。",player[n],"の手札のうち左から何番目を引きますか (  1 ～",tranpu[n].count," )の範囲で")
        Get=Int(readLine()!)!
        while(Get<1 || Get>tranpu[n].count){
            print( " 1 ～",tranpu[n].count," の範囲で")
            Get=Int(readLine()!)!
        }
    }
    
}

//手札がなくなったことを示す関数
func finish_person(end:Int,myturn:Int,player:[String]){
    if(end==myturn){
        print("上がりました。")
    }else{
        print(player[end],"が上がりました。")
    }
}

func geme_end(card:inout[[String]],player:[String],tranpu:[[Int]],myturn:Int){
    for i in 0...3{
        if(tranpu[i][0]==0){
            card[i][0]="Joker"  //最後までババ(ジョーカー)を持っていたことを表示させるよう設定
        }else{
            card[i][0]="上がり" //手札がないことを表示させるよう設定
        }
        if(i==myturn){
            print(" Me ",card[i])
        }else{
           print(player[i],card[i])
        }
    }
}
func main(){
    var tranpu:[[Int]]=Array(repeating:[1,2,3,4,5,6,7,8,9,10,11,12,13],count:4) //トランプの設定
    var card:[[String]]=Array(repeating:Array(repeating:"■",count:13),count:4)  //手札の初期設定
    let player:[String]=["Stop","Call","Take","Hold"]                           //プレイヤーの名前の設定
    
    let k=Int.random(in:0...3)          //最初にババ(ジョーカー)を持つ人の設定
    let myturn=Int.random(in:0...3)     //自分のターンを設定(1番目から4番目の中から設定)
    var member=4                        //手札を持つプレイヤーの人数
    var Get=0                           //入手するカード(左から何番目の手札を入手するか)を指定する変数
    var Get_card=0                      //入手したカード(AやJokerなど)を示す変数
    var n=0                             //入手されるプレイヤーを指定する変数
    var same=0                          //入手したカードと各プレイヤーの持つカードの数字が一致したことを示すフラグ
    var J=0                             //各プレイヤーが持つ手札の中から入手したカードと同じカードの場所を示す変数
    var turn=1                          //ターンを示す変数
    var end:Int                         //最後の1枚を引かれたことにより手札がなくなったプレイヤーを示す変数
    var flag=0                          //数字が一致したことにより上がったことを示すフラグ
    
    var juni:[Int]=Array(repeating:4,count:4)   //各プレイヤーの順位を示す配列
    
    tranpu[k].append(0)                         //最初にババを持つプレイヤーにババ(ジョーカー)を追加Expressions
    card[k].append("■")
    for i in 0...3{
        tranpu[i].shuffle()             //各プレイヤーの持つ手札をシャッフル(安易に欲しいカードを入手できなくするため)
    }
    
    while(member>1){
        for i in 0...3{
            if(flag==1){        //前のプレイヤーが数字の一致により抜けた場合に
                flag=0          //そのプレイヤーの前のプレイヤーが持つカードを引かないようにする
                break
            }
            if(tranpu[i][0]==99){   //各プレイヤーの手札がない場合に
                continue            //各プレイヤーがカードを引くのをスキップする
            }else{
                print_card(tranpu:tranpu,card:&card,myturn:myturn,player:player) //手札の表示
                n=(i+3)%4           //カードを引かれるプレイヤーの指定
                while(tranpu[n][0]==99){
                    n=(n+3)%4
                }
                print(turn,"ターン目")
                
                //どこのカードを引くかの指定
                if(i==myturn){
                    my_get(Get:&Get,tranpu:tranpu,n:n,player:player)
                }else{
                    print(player[i],"の番")
                    Get=Int.random(in:1...tranpu[n].count)
                }
                
                //何が引かれたのかを表示
                if(n==myturn){
                    if(card[n].count==1){
                        print("最後の一枚が引かれました")
                    }else{
                        print("自分の手札のうち左から",Get,"番目を引かれました")
                    }
                }else{
                    if(card[n].count==1){
                        print(player[n],"の最後の一枚を引きました")
                    }else{
                        print(player[n],"の手札のうち左から",Get,"番目を引きました")
                    }
                }
                Get_card=tranpu[n][Get-1]
                
                if(tranpu[n].count==1){ //引かれたのが最後の1枚かどうか
                    end=n
                    finish_person(end:end,myturn:myturn,player:player)
                    tranpu[n][0]=99     //手札が無くなったことを示すよう設定
                    card[n][0]="上がり"
                    juni[n]=5-member    //順位を格納(例:プレイヤーが3人の時に上がる場合:5-3=2[位])
                    member=member-1     //手札を持つプレイヤーを減らす
                }else{
                    tranpu[n].remove(at:Get-1)
                    card[n].remove(at:Get-1)
                }
                
                //引いたカードを引いたプレイヤーの手札に追加
                tranpu[i].append(Get_card);
                card[i].append("■");
                
                for j in 0...(tranpu[i].count-2){
                    if(tranpu[i][j]==Get_card){ //引いたカードが引いたプレイヤーの手札と一致したかどうか
                        same=1
                        J=j
                    }
                }
                
                //引いたカードが引いたプレイヤーの手札と一致した場合何が一致したかの表示
                if(same==1){
                    switch(Get_card){
                    case 1 : print("Aが揃いました"); break
                    case 2 : print("2が揃いました"); break
                    case 3 : print("3が揃いました"); break
                    case 4 : print("4が揃いました"); break
                    case 5 : print("5が揃いました"); break
                    case 6 : print("6が揃いました"); break
                    case 7 : print("7が揃いました"); break
                    case 8 : print("8が揃いました"); break
                    case 9 : print("9が揃いました"); break
                    case 10 : print("10が揃いました"); break
                    case 11 : print("Jackが揃いました"); break
                    case 12 : print("Queenが揃いました"); break
                    case 13 : print("Kingが揃いました"); break
                    default : break
                    }
                    if(tranpu[i].count==2){ //引いたカードが引いたプレイヤーの手札と一致したことによって手札が無くなるかどうか
                        end=i
                        finish_person(end:end,myturn:myturn,player:player)
                        tranpu[i][0]=99         //手札が無くなったことを示すよう設定
                        tranpu[i].remove(at:1)
                        card[i].remove(at:1)
                        juni[i]=5-member        //順位を格納(例:プレイヤーが3人の時に上がる場合:5-3=2[位])
                        member=member-1         //手札を持つプレイヤーを減らす
                        flag=1
                    }else{
                        //揃ったカードのペアを捨てる
                        tranpu[i].remove(at:tranpu[i].count-1)
                        tranpu[i].remove(at:J)
                        card[i].remove(at:card[i].count-1)
                        card[i].remove(at:J)
                    }
                    same=0
                    J=0
                }
            }
            n=0
            turn=turn+1
            if(member==1){  //手札を持つプレイヤーが1人しかいなくなった場合
                break
            }
        }
    }
    
    print("ゲームが終了しました。")
    geme_end(card:&card,player:player,tranpu:tranpu,myturn:myturn) //各プレイヤーが持つ手札の最終結果を表示
    
    for i in 0...3{
        //各プレイヤーの順位を表示
        if(i==myturn){
            print("自分の順位 :",juni[i],"位")
        }else{
            print(player[i],"の順位 :",juni[i],"位")
        }
    }
}
main()
