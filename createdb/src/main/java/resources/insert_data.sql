-- INSERT publishers
select add_pub('Akademnashr', 'Toshkent sh. Shayxontohur', '712025424');;
select add_pub('Hilol nashr', 'Toshkent sh. Chilonzor', '712025425');;
select add_pub('O''qituvchi', 'Toshkent sh. Shayxontohur', '712025426');;
select add_pub('Sharq NMIU', 'Toshkent sh. Yunusobod', '712025427');;
select add_pub('O''zbekiston', 'Toshkent sh. Mirobod', '712025428');;
select add_pub('G''afur G''ulom', 'Toshkent sh. Olmazor', '712025429');;

-- INSERT tags
select add_tag('jahon adabiyoti');;
select add_tag('o''zbek adabiyoti');;
select add_tag('bolalar adabiyoti');;
select add_tag('nasr');;
select add_tag('nazm');;
select add_tag('bestseller');;
select add_tag('modern');;
select add_tag('postmodern');;
select add_tag('klassik');;
select add_tag('ilmiy');;
select add_tag('badiiy');;

-- INSERT books
select add_book('Hech', 'Murod Chovush', 1, 2020, null, '{2, 4, 7}');;
select add_book('Faust', 'Iogann Gyote', 5, 2012, '123-54-251', '{1, 5, 9}');;
select add_book('Sapiens', 'Yuval Noa Harari', 1, 2020, null, '{1, 6, 10}');;

-- INSERT comments
SELECT add_comment('Shurik', 1, 'Juda g''alati yozilgan. Hech narsa tushunmadim, balki yozuvchiyam tushunmagandir. Tavsiya qilmayman');;
SELECT add_comment('Dima', 2, 'hali o''qimadim)');;
SELECT add_comment('Nurbek', 3, 'Yoshlar - yoshlar uchun!');;