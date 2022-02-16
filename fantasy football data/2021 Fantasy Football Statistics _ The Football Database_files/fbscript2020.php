 var lgs = {"NFL":{"a":1940,"b":2021,"c":1978,"d":2021,"e":1922,"f":2021,"g":2000,"h":2021,"j":1922,"k":2021,"l":1922,"m":2021,"n":1960,"o":2021,"p":1978,"q":2021},"CFL":{"a":2016,"b":2021,"c":2016,"d":2021,"e":1969,"f":2021,"g":2018,"h":2019,"j":2016,"k":2021,"l":1987,"m":2021,"n":2015,"o":2021},"AAF":{"a":2019,"b":2019,"c":2019,"d":2019,"e":2019,"f":2019,"j":2019,"k":2019,"l":2019,"m":2019},"AFL":{"a":1960,"b":1969,"e":1960,"f":1969,"j":1960,"k":1969,"l":1960,"m":1969,"n":1960,"o":1966},"AAFC":{"a":1946,"b":1949,"e":1946,"f":1949,"j":1946,"k":1949,"l":1946,"m":1949},"APFA":{"e":1920,"f":1921,"j":1920,"k":1921,"l":1920,"m":1921},"NFLE":{"a":1998,"b":2007,"e":1998,"f":2007,"j":1998,"k":2007,"l":1998,"m":2007,"p":2004,"q":2007},"WLAF":{"a":1991,"b":1997,"e":1991,"f":1997,"j":1991,"k":1997,"l":1991,"m":1997},"XFL":{"a":2020,"b":2020,"c":2020,"d":2020,"e":2020,"f":2020,"j":2020,"k":2020,"l":2020,"m":2020},"TSL":{"a":2021,"b":2021,"e":2021,"f":2021,"j":2020,"k":2021,"l":2021,"m":2021}};


 var STATUS_FINAL = 1;

 function resetStatsForm ()
 {
   var sY = $("#fld_statyr").val();
   if (lgs[$("#fld_statlg").val()].a && lgs[$("#fld_statlg").val()].b)
   {
     $("#fld_statyr").empty();
     for (var y = lgs[$("#fld_statlg").val()].b; y >= lgs[$("#fld_statlg").val()].a; y--) { $("#fld_statyr").append($("<option></option>").attr("value",y).text(y)); }
     if (sY>=lgs[$("#fld_statlg").val()].a && sY<=lgs[$("#fld_statlg").val()].b) { $("#fld_statyr").val(sY); }
     $("#fld_statyr").selectpicker("refresh");
   }
   resetConfOpts();
 }

 function resetSeasonDropDown (id_league, id_year, id_conf)
 {
   var sY = $("#"+id_year).val(), nY = "", str = "";
   var frag = id_year.replace(/^fld_/, "");
   var minyear = (frag=="tstatyr") ? lgs[$("#"+id_league).val()].c : lgs[$("#"+id_league).val()].a;
   var maxyear = (frag=="tstatyr") ? lgs[$("#"+id_league).val()].d : lgs[$("#"+id_league).val()].b;

   if (minyear && maxyear)
   {
     for (var y = maxyear; y >= minyear; y--) { str += '<li><a href="#" data-value="'+y+'">'+y+'</a></li>'; }
     if (sY>=minyear && sY<=maxyear) { nY = sY; }
     else { nY = lgs[$("#"+id_league).val()].b; }
   }

   $("#list_"+frag).html(str);
   $("#fld_"+frag).val(nY);
   $("#btnlabel_"+frag).html(nY);
   $("#btnlabelxs_"+frag).html(nY);
   if (id_conf!="") { resetConfDropDown(id_league, id_year, id_conf); }
 }

 function resetConfOpts ()
 {
   var sL = $("#fld_statlg").val();
   var sY = $("#fld_statyr").val();
   var sC = $("#fld_statconf").val();
   $("#fld_statconf option:gt(0)").remove();
   if ($("#fld_statlg").val()=="NFL" && $("#fld_statyr").val()>1969)
   {
     $("#fld_statconf").append($("<option></option>").attr("value","AFC").text("AFC Only"));
     $("#fld_statconf").append($("<option></option>").attr("value","NFC").text("NFC Only"));
   }
   if (sL=="NFL" && (sC=="AFC" || sC=="NFC") && sY>1969) { $("#fld_statconf").val(sC); }
   $("#fld_statconf").selectpicker("refresh");
 }

 function resetConfDropDown (id_league, id_year, id_conf)
 {
   var sL = $("#"+id_league).val();
   var sY = $("#"+id_year).val();
   var sC = $("#"+id_conf).val();
   var frag = id_conf.replace(/^fld_/, "");
   $("#list_"+frag+" li:gt(0)").remove();

   if (sL=="NFL" && sY>1969)
   {
     $("#list_"+frag).append($('<li><a href="#" data-value="AFC">AFC Only</a></li>'));
     $("#list_"+frag).append($('<li><a href="#" data-value="NFC">NFC Only</a></li>'));
   }

   if (sL=="NFL" && (sC=="AFC" || sC=="NFC") && sY>1969)
   {
     $("#fld_"+frag).val(sC);
     $("#btnlabel_"+frag).html(sC + " Only");
     $("#btnlabelxs_"+frag).html(sC + " Only");
   }
   else
   {
     $("#fld_"+frag).val("");
     $("#btnlabel_"+frag).html("Entire League");
     $("#btnlabelxs_"+frag).html("Entire League");
   }
 }

 function resetStandingsForm ()
 {
   var sY = $("#fld_standyr").val();
   if (lgs[$("#fld_standlg").val()].e && lgs[$("#fld_standlg").val()].f)
   {
     $("#fld_standyr").empty();
     for (var y = lgs[$("#fld_standlg").val()].f; y >= lgs[$("#fld_standlg").val()].e; y--) { $("#fld_standyr").append($("<option></option>").attr("value",y).text(y)); }
     if (sY>=lgs[$("#fld_standlg").val()].e && sY<=lgs[$("#fld_standlg").val()].f) { $("#fld_standyr").val(sY); }
     $("#fld_standyr").selectpicker("refresh");
   }
 }

 function resetScoresForm ()
 {
   var sY = $("#fld_scoreyr").val();
   if (lgs[$("#fld_scorelg").val()].l && lgs[$("#fld_scorelg").val()].m)
   {
     $("#fld_scoreyr").empty();
     for (var y = lgs[$("#fld_scorelg").val()].m; y >= lgs[$("#fld_scorelg").val()].l; y--) { $("#fld_scoreyr").append($("<option></option>").attr("value",y).text(y)); }
     if (sY>=lgs[$("#fld_scorelg").val()].l && sY<=lgs[$("#fld_scorelg").val()].m) { $("#fld_scoreyr").val(sY); }
     $("#fld_scoreyr").selectpicker("refresh");
   }
 }

 function resetSeasonsForm ()
 {
   var sY = $("#fld_seasonyr").val();
   if (lgs[$("#fld_seasonlg").val()].j && lgs[$("#fld_seasonlg").val()].k)
   {
     $("#fld_seasonyr").empty();
     for (var y = lgs[$("#fld_seasonlg").val()].k; y >= lgs[$("#fld_seasonlg").val()].j; y--) { $("#fld_seasonyr").append($("<option></option>").attr("value",y).text(y)); }
     if (sY>=lgs[$("#fld_seasonlg").val()].j && sY<=lgs[$("#fld_seasonlg").val()].k) { $("#fld_seasonyr").val(sY); }
     $("#fld_seasonyr").selectpicker("refresh");
   }
 }

 function resetDraftForm ()
 {
   var sY = $("#fld_draftyr").val();
   if (lgs[$("#fld_draftlg").val()].n && lgs[$("#fld_draftlg").val()].o)
   {
     $("#fld_draftyr").empty();
     for (var y = lgs[$("#fld_draftlg").val()].o; y >= lgs[$("#fld_draftlg").val()].n; y--) { $("#fld_draftyr").append($("<option></option>").attr("value",y).text(y)); }
     if (sY>=lgs[$("#fld_draftlg").val()].n && sY<=lgs[$("#fld_draftlg").val()].o) { $("#fld_draftyr").val(sY); }
     $("#fld_draftyr").selectpicker("refresh");
   }
 }

 function resetBoxscoresForm ()
 {
   var sY = $("#fld_boxyr").val();
   if (lgs[$("#fld_boxlg").val()].p && lgs[$("#fld_boxlg").val()].q)
   {
     $("#fld_boxyr").empty();
     for (var y = lgs[$("#fld_boxlg").val()].q; y >= lgs[$("#fld_boxlg").val()].p; y--) { $("#fld_boxyr").append($("<option></option>").attr("value",y).text(y)); }
     if (sY>=lgs[$("#fld_boxlg").val()].p && sY<=lgs[$("#fld_boxlg").val()].q) { $("#fld_boxyr").val(sY); }
     $("#fld_boxyr").selectpicker("refresh");
   }
 }

 function getDraft (id, season, league)
 {
   //console.log("Getting Draft Results");
   $.ajax({
     type: "GET",
     url: "/data/draft_results.php",
     data: { yr:season, lg:league },
     success: function (data) {
       if (!data.livedraft) { $("#"+id).removeClass("livedraft"); }
       $.each(data.picks, function(i, v){
         $("#"+id+"_team_"+v.draftid).html('<a href="'+v.team_url+'">'+v.teamname+'</a>');
         if (v.playerid) {
           var pstr = '<a href="'+v.profile_url+'">'+v.playername+'</a>';
           var plinfo = '<br />'+pstr+(v.position!=''?', '+v.position:'')+(v.college!=''?'<br />'+v.college:'');
           $("#"+id+"_player_"+v.draftid).html(pstr);
           $("#"+id+"_pos_"+v.draftid).html(v.position);
           $("#"+id+"_coll_"+v.draftid).html(v.college);
           $("#"+id+"_plinfo_"+v.draftid).html(plinfo);
         }
       });
     }
   });
 }

 function getScores (id)
 {
   console.log("Getting Scores");
   var inprogress = 0;
   $.ajax({
     type: "GET",
     url: "/data/gamescores.php",
     success: function (data) {
       if (!data.livescores) { $("#"+id).removeClass("livescores"); }
       $.each(data.games, function(i, v){
         $("#vscore_"+v.gameid).html(v.scorev);
         $("#hscore_"+v.gameid).html(v.scoreh);
         //$("#gclock_"+v.gameid).html(v.clock);
         if (v.status==STATUS_FINAL && v.gameurl!="") { $("#gstatus_"+v.gameid).html('<a href="'+v.gameurl+'">'+v.gamestatus+'</a>'); }
         else { $("#gstatus_"+v.gameid).html(v.gamestatus); }
         if (v.status!=STATUS_FINAL) { inprogress++; }
       });
     }
   });
 }

 $(document).ready(function() {

   $("#dl-menu").clone().prop({id:"dl-menu-mobile"}).insertAfter("#navbar-trigger");

   $("#dl-menu-mobile").dlmenu({
     animationClasses : { classin : 'dl-animate-in-2', classout : 'dl-animate-out-2' }
   });

   $("#dl-menu a[href='#']").click(function(){
     return false;
   });

   if ($("#nextgame").length && $("#lastgame").length)
   {
     if ($("#lastgame").height() > $("#nextgame").height()) { $("#nextgame").height($("#lastgame").height()); }
     else { $("#lastgame").height($("#nextgame").height()); }
   }

   if ($("#rightcol #divFeatured").length > 0 && $("#rightcol #divLiveStandings").length > 0)
   {
     var fpos = $("#rightcol #divFeatured").position();
     var spos = $("#rightcol #divLiveStandings").position();
     var fbot = fpos.top + $("#rightcol #divFeatured").height();
     if (spos.top+$("#rightcol #divLiveStandings").height() < fbot) { $("#rightcol #divLiveStandings").height(fbot-spos.top); }
   }

   $("[id*='_btnconf_']").click(function(){
     var p = $(this).attr("id").split("_")
     var curdiv = $("#"+p[0]+"_divbtns input[type='radio'][name='"+p[0]+"_division']:checked").val();
     var showdiv = p[2] + curdiv;
     $("[name='"+p[0]+"_conf']").removeAttr("checked");
     $("[name='"+p[0]+"_conf'][value='"+p[2]+ "']").prop('checked', true);
     $("[id^='"+p[0]+"_btnconf_']").each(function(){ $(this).removeClass("active"); });
     $(this).addClass("active");
     $("[id^='"+p[0]+"_ls_']").each(function(){ $(this).removeClass("widget_block_shown"); });
     $("#"+p[0]+"_ls_"+showdiv).addClass("widget_block_shown");
     return false;
   });

   $("[id*='_btndiv_']").click(function(){
     var p = $(this).attr("id").split("_")
     var curconf = $("input[type='radio'][name='"+p[0]+"_conf']:checked").val();
     var showdiv = curconf + p[2];
     $("[name='"+p[0]+"_division']").removeAttr("checked");
     $("[name='"+p[0]+"_division'][value='"+p[2]+ "']").prop('checked', true);
     $("[id^='"+p[0]+"_btndiv_']").each(function(){ $(this).removeClass("active"); });
     $(this).addClass("active");
     $("[id^='"+p[0]+"_ls_']").each(function(){ $(this).removeClass("widget_block_shown"); });
     $("#"+p[0]+"_ls_"+showdiv).addClass("widget_block_shown");
     return false;
   });

   $("[id*='_btnstat_']").click(function(){
     var p = $(this).attr("id").split("_");
     $("[id*='_btnstat_']").each(function(){ $(this).removeClass("active"); });
     $("[id^='"+p[0]+"_sw_']").each(function(){ $(this).hide(); });
     $("#"+p[0]+"_sw_"+p[2]).fadeIn();
     $(this).addClass("active");
   });

   $("[id*='_btnround_']").click(function(){
     var p = $(this).attr("id").split("_");
     $("[id^='"+p[0]+"_btnround_']").each(function(){ $(this).removeClass("active"); });
     $(this).addClass("active");
     $("[id^='"+p[0]+"_ls_']").each(function(){ $(this).hide(); });
     $("#"+p[0]+"_ls_"+p[2]).fadeIn();
     return false;
   });

   $("[id^='expand_']").click(function(){
     var cls = $(this).attr('id').replace(/^expand_/, "");
     if ($(this).attr("src").match(/minus/)) { $("."+cls).hide(); $(this).attr("src", "/images/plus.gif"); }
     else { $("."+cls).show(); $(this).attr("src", "/images/minus.gif"); }
   });

   $("[id^='link_hp_']").click(function(){
     var p = $(this).attr("id").split("_");
     //var cls = $(this).attr('id').replace(/^link_/, "");
     var grp = p[1];
     var div = p[2];
     //$("[id^='div_"+grp+"_']").each(function(){ $(this).hide(); });
     $("[id^='div_"+grp+"_']").each(function(){ $(this).addClass("hp_block_hidden"); });
     $("#div_"+grp+"_"+div).fadeIn(function(){
       $(this).removeClass("hp_block_hidden");
       $(this).css({display:''});
     });
     //$("#div_"+grp+"_"+div).removeClass("hp_block_hidden");
     $("[id^='link_"+grp+"_']").each(function(){ $(this).removeClass("active"); });
     $(this).addClass("active");
     $("[id^='li_"+grp+"_']").each(function(){ $(this).removeClass("active"); });
     $("#li_"+grp+"_"+div).addClass("active");
     return false;
   });

/*
   //if ($("#liveScoreboard").length==1)
   $("#liveScoreboard").each(function(){
     // Every 120 seconds
     var scoreboardTimer = setInterval("getScores()", 120000);
   });
*/

   $(".livescores").each(function(){
     var id = $(this).attr("id");
     var yr = $(this).data("season");
     var lg = $(this).data("league");
     var type = $(this).data("gametype");
     var wk = $(this).data("week");
     var scoreboardTimer = setInterval(function(){
       getScores(id);
       if (!$("#"+id).hasClass("livescores")) { clearInterval(scoreboardTimer); }
     }, 10000);
   });

   $(".livedraft").each(function(){
     var id = $(this).attr("id");
     var yr = $(this).data("season");
     var lg = $(this).data("league");

     var draftTimer = setInterval(function(){
       getDraft(id,yr,lg);
       //if (!livedraft) { clearInterval(draftTimer); }
       if (!$("#"+id).hasClass("livedraft")) { clearInterval(draftTimer); }
     }, 120000);
   });

   $(".selectpicker").each(function(){
     var style = $(this).data("style") || "btn-footballdb btn-smxs";
     var width = $(this).data("width");
     $(this).selectpicker({
       style: style,
       size: 10
     });
   });

/*
   $(".selectpicker").selectpicker({
     //style: "btn-footballdb btn-smxs",
     //style: $(this).data("style") || "btn-footballdb btn-smxs",
     style: $(this).attr("data-style") ? $(this).attr("data-style") : "btn-footballdb btn-smxs",
   });
*/

   $("#formTeams #fld_team").change(function(){
     window.location = $(this).val();
   });

   $("#formCollegeTeams #fld_collteam").change(function(){
     window.location = $(this).val();
   });

   $("#fld_prospects_season").change(function(){
     if ($(this).val()!="") { $("#form_prospects_season").submit(); }
   });

   $("#fld_prospects_letter").change(function(){
     if ($(this).val()!="") { $("#form_prospects_letter").submit(); }
   });

   $("#fld_prospects_pos").change(function(){
     if ($(this).val()!="") { $("#form_prospects_pos").submit(); }
   });

   $("#fld_prospects_cid").change(function(){
     if ($(this).val()!="") { $("#form_prospects_cid").submit(); }
   });

   $("#btnTransCalendar").datepicker({
     format: "yyyy-mm-dd",
     startView: 'months',
     minViewMode: 'months',
     maxViewMode: 'years',
     orientation: 'auto',
     container: '#divTransNav',
   }).on("click", function(e){
     if($(this).hasClass("openX")){
        $(this).removeClass("openX").addClass("closeX");
        $(this).datepicker("hide");
     } else {
        $(this).removeClass("closeX").addClass("openX");
        //$(this).datepicker("open");
     }
   }).on("changeDate", function(e){
     window.location = window.location.pathname + "?period=" + e.format('yyyymm');
   }).on("hide", function(e){
     $(this).removeClass("openX").addClass("closeX");
   });

   $("#formMatchups").submit(function(){

     if ($("#fldMatchupTeam").val()=="" || $("#fldMatchupOpp").val()=="" || $("#fldMatchupTeam").val()==$("#fldMatchupOpp").val())
     {
       alert("Please select a valid matchup to continue.");
       return false;
     }

     var tmparams = $("#fldMatchupTeam").val().split("|");
     var oppparams = $("#fldMatchupOpp").val().split("|");
     window.location = "/teams/nfl/" + tmparams[1] + "/teamvsteam?opp=" + oppparams[0];
     return false;
   });

   $("[id^='btnDivToggle_']").click(function(){
     var divid = $(this).attr('id').replace(/^btnDivToggle_/, "");
     $("[id^='btnDivToggle_']").each(function(){ $(this).removeClass("active"); });
     $(this).addClass("active");
     $("[id^='divToggle_']").each(function(){ $(this).hide(); });
     $(".divToggle_"+divid).removeClass("hidden-xs").fadeIn();

     // Fix for scrolling tables
     $(".tablesorter").trigger("applyWidgets");

   });

   $("[id^='btnBox_']").click(function(){
     var boxtype = $(this).attr('id').replace(/^btnBox_/, "");
     var divid = (boxtype=="visitor" || boxtype=="home") ? "stats" : boxtype;
     $("[id^='btnBox_']").each(function(){ $(this).removeClass("active"); });
     $(this).addClass("active");
     $("[id^='divBox_']").each(function(){ $(this).hide(); });
     $("#divBox_"+divid).removeClass("hidden-xs").fadeIn();
     if (divid=="stats")
     {
       $("div.boxdiv_"+boxtype).each(function(){ $(this).show(); });
       $("div.boxdiv_"+(boxtype=="visitor"?"home":"visitor")).each(function(){ $(this).hide(); });
     }
     // Fix for scrolling tables
     $(".tablesorter").trigger("applyWidgets");

   });



   // Enable table scrolling
   $("table.scrollable").wrap("<div class='table-scroller'></div>");
   //$("div.table-scroller:first").prepend('<div class="swipediv">Swipe to see more</div>');

   var updateTables = function(){
     $("table.scrollable").each(function(){
       var switched = ($(this).data("switched")==true);
       if (($(window).width() < 768) && !switched) {
         $(this).data("switched",true);
         $(this).tablesorter({
           headers: {'th':{sorter:false}},
           widgets: ['scroller'],
           widgetOptions : {
             scroller_upAfterSort: true,
             scroller_jumpToHeader: true,
             scroller_height : 0,
             scroller_fixedColumns : $(this).data("fixed-columns") || 1,
             //scroller_addFixedOverlay : false,
             scroller_rowHighlight : 'hover',
             //scroller_barWidth : null
           }
         });
       }
       else if (switched && ($(window).width() > 767) && !$(this).is(function(index,element){return $(element).attr("class").match(/_extra_table/);})) {
       //else if (switched && ($(window).width() > 767) && $(this).not("[class*='_extra_table']")) {
       //else if (switched && ($(window).width() > 767)) {
         $(this).data("switched",false);
         $(this).trigger("destroy", true);
         $(this).unbind("mouseover");
         $(this).removeClass("tablesorter tablesorter-default");
         $(this).find("colgroup.tablesorter-colgroup").remove();
         $(this).find("tr.tablesorter-scroller-spacer").remove();
         $(this).find("tr").removeClass("hover");
         $(this).find("th,td").removeClass("tablesorter-scroller-hidden-column");
         $(this).find("th").removeClass("sorter-false");
       }
     });
   };

   $(window).load(updateTables);
   //$(window).on("redraw",function(){updateTables();});
   $(window).on("redraw",function(){switched=false;updateTables();});
   $(window).on("resize", updateTables);


   $(".linkDefense").click(function(){
     var dfsid = $("#dfsmodal").data("dfsid");
     var pos = $("#dfsmodal").data("position");
     $("#dfsmodal").load("dfsranks.php?dfsid="+dfsid+"&pos="+pos, "", function(){
       $("#dfsmodal").modal({
         keyboard:true
       });
     });
     return false;
   });

   $(document).on("click", ".linkPlayers", function(e){
     e.preventDefault();
     var pid = $(this).data("playerid");
     var dfsid = $("#dfsmodal").data("dfsid");
     //alert("Clicked " + pid);

     $("#dfsmodal").load("playerdetail3.php?pid="+pid+"&dfsid="+dfsid, "", function(){
       $("#dfsmodal").modal({
         keyboard:true
       });
     });

     return false;
   });

   // Make bootstrap dropdowns automatically dropup if at bottom of page
   $(document).on("shown.bs.dropdown", ".dropdown", function () {
       // calculate the required sizes, spaces
       var $ul = $(this).children(".dropdown-menu");
       var $button = $(this).children(".dropdown-toggle");
       var ulOffset = $ul.offset();
       // how much space would be left on the top if the dropdown opened that direction
       var spaceUp = (ulOffset.top - $button.height() - $ul.height()) - $(window).scrollTop() - 60;
       // how much space is left at the bottom
       var spaceDown = $(window).scrollTop() + $(window).height() - (ulOffset.top + $ul.height());
       // switch to dropup only if there is no space at the bottom AND there is space at the top, or there isn't either but it would be still better fit
       //if (spaceDown < 0 && (spaceUp >= 0 || spaceUp > spaceDown))
       // Changed so only use dropup if entire menu can fit above
       if (spaceDown < 0 && spaceUp >= 0)
         $(this).addClass("dropup");
   }).on("hidden.bs.dropdown", ".dropdown", function() {
       // always reset after close
       $(this).removeClass("dropup");
   });

   // select buttons
   $(document).on("click", ".btn-select li a", function(){
     var newval = $(this).data("value");
     var $btn = $(this).closest(".btn-select").find("button").first();
     if ($btn.length > 0)
     {
       var curid = $btn.attr("id").replace(/^btnselect_/,"");
       $("#fld_"+curid).val(newval);
       $("#fld_"+curid).change();
       $("#btnlabel_"+curid).html($(this).text());
       if ($(this).data("labelxs")) { $("#btnlabelxs_"+curid).html($(this).data("labelxs")); }
       else { $("#btnlabelxs_"+curid).html($(this).text()); }
       $btn.dropdown('toggle');
     }
     return false;
   });

   // Make bootstrap dropdowns automatically open to the right if at edge of page
   $(document).on("shown.bs.dropdown", ".btn-select.dropdown", function () {
     var $ul = $(this).children(".dropdown-menu");
     var $button = $(this).children(".dropdown-toggle");
     var ulOffset = $ul.offset();
     var dropdownWidth = $ul.width();
     var docWidth = $(window).width();
     if (ulOffset.left + dropdownWidth > docWidth) { $ul.addClass("dropdown-menu-autoright"); }
   }).on("hidden.bs.dropdown", ".dropdown", function() {
     // always reset after close
     var $ul = $(this).children(".dropdown-menu");
     $ul.removeClass("dropdown-menu-autoright");
   });

   $("#search-toggle").click(function(){
     //alert("Toggling search box");
     if ($("#sitesearch-xs").is(":visible")) { $("#sitesearch-xs").slideUp(200); }
     else { $("#sitesearch-xs").slideDown(200); $("#fld_xsq").typeahead("val",""); $("#fld_xsq").val("").focus(); }
   });

   var playerSearch = new Bloodhound({
     datumTokenizer: Bloodhound.tokenizers.obj.whitespace("name"),
     queryTokenizer: Bloodhound.tokenizers.whitespace,
     //prefetch: '../data/films/post_1960.json',
     remote: {
       url: "/data/fbsearch.php?q=%QUERY&t=1644857263",
       wildcard: '%QUERY',
       filter: function (datum) {
         return $.map(datum.players, function (data) {
           return data;
         });
       }

     }
   });

   $(".fld-sitesearch").typeahead(
   {
     minLength: 3,
     highlight: false,
     hint: false,
     classNames: { dataset: 'tt-table2' }
   },
   {
     limit: 200,
     name: 'player-search',
     display: 'name',
     source: playerSearch,
     templates: {
       notFound: '<div class="tt-empty">No results found</div>',
       suggestion: function (data) {
         var classname = (data.teamid > 0) ? 'tt-teamlogo tt-teamid-'+data.teamid : 'tt-noteamlogo';
         var str = '<div class="tr"><div class="td tt-spacer"></div>';
         str += '<div class="td ' + classname + '"></div>';
         str += '<div class="td tt-playerinfo">';
         str += '<div class="tt-playername"><a href="' + data.url + '">' + data.name + '</a></div>'
         str += '<div class="tt-posteam">' + data.position + ', ' + data.teamname + ' (' + data.league + ')</div>'
         str += '</div><div class="clear"></div></div>';
         return str;
       }
     }
   });

   $(".fld-sitesearch").bind('typeahead:select', function(obj, datum, name) {
       $(this).typeahead("val", "");
       window.location.href = datum.url;
   });

   $(".searchclear").click(function(){
     var inputid = $(this).attr('id').replace(/_clear$/, "");
     $("#"+inputid).val('');
     $("#"+inputid).typeahead('val','');
   });
 });
