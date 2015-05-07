
<script>
    function myFunction()
    {
        $.ajax({
            url: '<?php echo Yii::$app->request->baseUrl. '/../api/web/v1/answers' ?>',
            type: 'post',
            data: {value: $("#wordValue").val() , id: $("#searchby").val()},
            success: function (data) {
                console.log(data);
            }
        });
    }
</script>

<?php
use yii\helpers\Html;
use yii\widgets\LinkPager;

?>
<h1>Supermarkets</h1>
<ul>




<select id="searchby">
    <option value="" disabled="disabled" selected="selected">Choose</option>
    <option value="apple">1</option>
    <option value="pear">2</option>
</select>


<input type="text" value ="" name="wordValue", id="wordValue">
<button onclick="myFunction()">Search</button>
<h3> </h3>
