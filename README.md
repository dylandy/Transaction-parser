#台北果菜市場交易資料抓取機器人
###Taipei fruit and vegetable transaction information collecting parser

This parser would parse the transaction information from Taipei's trading centre.<br>
And would parse all of it from 2002-01-01 to today<br>
Be careful! This would cost about 20MB of disk space.<br>


##Require

1. Ruby-2.0<br>
2. Rubygems-current<br>
3. Active records<br>
4. Nokogiri<br>
5. Open-uri<br>
6. NetWork<br>
7. MySQL-server<br>

##Data Schema

###Vegetable
  <table>
     <tr> 
        <td>serial</td><td>name</td><td>r_name</td>
     </tr>
    <tr>
       <td>string</td><td>string</td><td>string</td>
    </tr>

  </table>

###VegetableLog
  <table>
    <tr>
      <td>price1</td><td>price2</td><td>price3</td><td>log_date</td><td>create_at</td><td>update_at</td><td>vegetable_id</td>
    </tr>
    <tr>
      <td>integer</td><td>integer</td><td>integer</td><td>date</td><td>datetime</td><td>datetime</td><td>integer</td>
    </tr>
  </table>

##Install

* Build the development database first<br>
* create "Vegetable" and "VegetableLog" table<br>
* change the password in the vege.rb with your own mysql server password<br>
* execute the vege.rb and then would get the information<br>

##Todo

* Multi-threading to make the parsing process faster.<br>


##Data resource
[台北農產運銷股份有限公司-Taipei Agricultural products markets co.](http://www.tapmc.com.tw/tapmc_new16/index.html)
