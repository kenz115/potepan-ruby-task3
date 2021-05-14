# コインとポイントの初期化
coin = 100
point = 0

# コインがなくなるまで繰り返し
while coin > 0 do

    # 縦、横、斜めで数字が揃っているか確かめるための配列の初期化
    result_hash = {
        "vertical0" => [],
        "vertical1" => [],
        "vertical2" => [],
        "side0" => [],
        "side1" => [],
        "side2" => [],
        "diagonal0" => [],
        "diagonal1" => [],
    }

    # 数字が揃った列の数と揃った場合に表示するメッセージを格納する変数の初期化
    align = 0
    message = []

    # 正しくbetされるまで繰り返し
    while true do
        puts "---------------------------------------------"
        puts "残りコイン数:#{coin}"
        puts "ポイント:#{point}"
        puts "何コイン入れますか？"
        puts "1(10コイン) 2(30コイン) 3(50コイン) 4(やめとく)"
        puts "---------------------------------------------"

        input_bet = gets.to_i

        # １〜４で入力されるまで繰り返し
        while input_bet.between?(1, 4) === false
            puts "１〜４の数字で入力してください"
            input_bet = gets.to_i
        end

        # betしたコイン数を変数に格納
        case input_bet
        when 1 then
            bet = 10
        when 2 then
            bet = 30
        when 3 then
            bet = 50
        when 4 then
            exit
        end

        # 残りコイン数を超えてbetしていないかの確認
        if bet > coin
            puts "コインが足りません"
        else
            coin -= bet
            break
        end
    end

    puts "エンターを３回押しましょう！"
    gets


    for i in 0..2 do
        # 縦と横の数字の並びを配列に格納
        for j in 0..2 do
            result_hash["vertical#{i}"].push(rand(1..9))
            result_hash["side#{j}"].push(result_hash["vertical#{i}"][j])
        end

        # 斜めの数字の並びを配列に格納
        result_hash["diagonal0"].push(result_hash["vertical#{i}"][i])

        # 斜めの数字の並びを配列に格納
        case i
        when 0 then
            result_hash["diagonal1"].push(result_hash["vertical#{i}"][2])
        when 1 then
            result_hash["diagonal1"].push(result_hash["vertical#{i}"][1])
        when 2 then
            result_hash["diagonal1"].push(result_hash["vertical#{i}"][0])
        end
    end

    # 数字が揃っているか確認し、揃っていればメッセージを配列に格納
    result_hash.each{ |key, value|
        if value.uniq.size === 1
            align += 1

            if key.include?("vertical")
                message.push("縦に#{value[0]}が揃いました！")
            elsif key.include?("side")
                message.push("横に#{value[0]}が揃いました！")
            elsif key.include?("diagonal")
                message.push("斜めに#{value[0]}が揃いました！")
            end     
        end
    }

    puts "-----------"
    for i in 0..2 do
        puts "|#{result_hash['vertical0'][i]}| || ||"
    end
    puts "-----------"

    gets

    puts "-----------"
    for i in 0..2 do
        puts "|#{result_hash['vertical0'][i]}| |#{result_hash['vertical1'][i]}| ||"
    end
    puts "-----------"

    gets

    puts "-----------"
    for i in 0..2 do
        puts "|#{result_hash['vertical0'][i]}| |#{result_hash['vertical1'][i]}| |#{result_hash['vertical2'][i]}|"
    end
    puts "-----------"

    puts message
    if align != 0
        puts "#{align * bet * 2}コイン獲得！"
        puts "#{align * bet * 10}ポイント獲得！"
    end
    
    # 獲得コインを獲得ポイントを変数に足す
    coin += (align * bet * 2)
    point += (align * bet * 10)
end

puts "結果：#{point}ポイント"
