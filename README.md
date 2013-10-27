#台北果菜市場交易資料抓取機器人
###Taipei fruit and vegetable transaction information collecting parser

This parser would parse the transaction information from Taipei's trading centre.<br>
And would parse all of it from 2002-01-01 to today<br>
Be careful! This would cost about 20MB of disk space.<br>


##Require

1. Ruby-2.0 || Maybe Ruby-1.9<br>
2. Rubygems-current<br>
3. Active records<br>
4. Nokogiri<br>
5. Open-uri<br>
6. NetWork<br>
7. MySQL-server<br>
8. YAML<br>
9. perfect print<br>

##Data Schema

<b>Note : Table VegetableLog is belonged to table Vegetable.</b>
###Catalog
  <table>
    <tr>
      <td>column name</td><td>name</td><td>kind</td><td>created_at</td><td>updated_at</td>
    </tr>
    <tr>
      <td>data type</td><td>string</td><td>integer</td><td>datetime</td><td>datetime</td>
    </tr>
  </table>
  <strong>:kind =>  limit:1 , null:false</strong>
###Vegetable
  <table>
     <tr> 
        <td>column name</td><td>serial</td><td>name</td><td>r_name</td>
     </tr>
    <tr>
       <td>data type</td><td>string</td><td>string</td><td>string</td>
    </tr>

  </table>
  <strong>:season,:kind => limit:1 , :form => limit:2</strong>
###VegetableLog
  <table>
    <tr>
     <td>column name</td> <td>price1</td><td>price2</td><td>price3</td><td>log_date</td><td>create_at</td><td>update_at</td><td>vegetable_id</td>
    </tr>
    <tr>
      <td>data type</td><td>integer</td><td>integer</td><td>integer</td><td>date</td><td>datetime</td><td>datetime</td><td>integer</td>
    </tr>
  </table>
  <strong>:vegetable_id => null:false</strong>

##Install

* Build the development database first<br>
* create "Vegetable" and "VegetableLog" table<br>
* change the password and username in the "database.yml" with your own mysql server user and password <br>
* change the path for database.yml in "vege.rb" to ensure that can connect to your database<br>
* execute the vege.rb and then would get the information<br>

##Todo

* Multi-threading to make the parsing process faster.<br>
* Some famous kinds of fruit and vegetable may not have any information.<br>


##Data resource
[台北農產運銷股份有限公司-Taipei Agricultural products markets co.](http://www.tapmc.com.tw/tapmc_new16/index.html)
