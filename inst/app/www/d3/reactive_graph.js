// !preview r2d3 data=rjson::fromJSON(file="inst/app/www/d3/reactive_graph_data.json")
//

var col_width = width/25
var row_height = height/22

// Add a title
svg.append("text")         // append text
    .attr("x", 1*col_width)         // set x position of left side of text
    .attr("y", 1*row_height)           // set y position of bottom of text
    .attr("dy", ".35em")           // set offset y position
    .text("The Reactive Graph")
    .attr("class", "title")

// Define the steps and their labels
var steps = [
  {
    id : "step_1",
    name: "Step 1",
    label: "1) The app is initiated with 3 reactive values/producers (A, B and C), three reactive expressions/conductors (D, E and F), and 2 observers/outputs (G and H). The reactive values are already calculated upon the app starting, while the rest have not been calculated - they are invalidated."
  },
  {
    id:"step_2",
    name: "Step 2",
    label: "2) Shiny chooses an invalidated output at random (H) and starts calculating it."
  },
  {
    id: "step_3",
    name: "Step 3",
    label: "3) While calculating, it realises that H depends on E, so it creates a reactive dependency (denoted by a line between the two) and starts calculating E."
  },
  {
    id: "step_4",
    name: "Step 4",
    label: "4) As with step 3, shiny realises that E depends on B. As a reactive value, B is already calculated and so E can be calculated."
  },
  {
    id: "step_5",
    name: "Step 5",
    label: "5) When B and E have been calculated, H continues calculating but shiny can see it also relies on F."
  },
  {
    id: "step_6",
    name: "Step 6",
    label: "6) The same steps are repeated to work back until a value is found and then calculate forward, until H can be calculated."
  },
  {
    id: "step_7",
    name: "Step 7",
    label: "7) Another output is chosen at random and the same process happens until all objects have been calculated and are resting."
  },
  {
    id: "step_8",
    name: "Step 8",
    label: "8) After some time, the user interacts with the app to change the value of B, so this becomes invalidated."
  },
  {
    id: "step_9",
    name: "Step 9",
    label: "9) Using the identified dependencies, shiny invalidates anything which depends on B, working from left to right."
  },
  {
    id: "step_10",
    name: "Step 10",
    label: "10) Next, the dependencies are destroyed (this lets shiny rediscover dependencies ensuring it is as dynamic as possible). Note that all dependencies in and out of an invalidated node are destroyed. The new value of B is computed (taken from the user input)."
  },
  {
    id: "step_11",
    name: "Step 11",
    label: "11) Once the dependencies have been destroyed, shiny begins again by choosing a random invalidated output (G this time) and recalculating it."
  },
  {
    id: "step_12",
    name: "Step 12",
    label: "12) As before, it cannot be calculated without the value of D and so this is calculated. And so on, until the app is once again at a resting state, waiting for the next user interaction."
  },
  {
    id: "run_all",
    name: "Play all",
    label: ""
  }
]

var buttons = svg.selectAll("div")
                  .data(steps)
                  .enter()
                  .append("g")
                  .attr("id", function(d){return d.id})

// Create each button down right hand side of graph
buttons.append("rect") // attach a rectangle
    .attr("id", function(d){return d.id+"_rect"})
    .attr("class", "unselected-button")
    .attr("x", function(d,i){return 21*col_width})
    .attr("y", function(d,i){return (i+1)*(row_height*1.1)})
    .attr("height", row_height)    // set the height
    .attr("width", 2*col_width)
    .attr("rx", 5)
    .attr("ry", 5);    // set the width

// Add label to each button
buttons.append("text")
    .style("fill", "white")
    .attr("text-anchor", "middle")
    .attr("x", function(d,i){return (22*col_width)})
    .attr("y", function(d,i){return (i+1)*(row_height*1.1)+(row_height*0.55)})
    .text(function(d){return d.name})

// Add commentary to bottom of graph
svg.selectAll("commentary")
  .data(steps)
  .enter()
  .append("foreignObject")
    .attr("width", col_width*19)
    .attr("height", row_height*6)
    .attr("x", col_width*2)
    .attr("y", row_height*18)
  .append("xhtml:body")
    .style("font", "18px 'Helvetica Neue'")
  .attr("id", function(d){return d.id+"_desc"})
  .attr("x", (2*col_width))
  .attr("y", (21*row_height))
  .attr("fill", "black")
  .style("visibility", "hidden")
  .html(function(d){return "<p>"+d.label+"</p>"})

// Create links
var links = svg
  .selectAll("links")
  .data(data.links)
  .enter()
  .append("g")
  .attr("id", function(d){return d.link_id})
  .append("line")
    .attr("x1", function(d){
      return (data.nodes[d.source_node].col)*col_width
    })
    .attr("x2", function(d){
      return (data.nodes[d.target_node].col)*col_width
    })
    .attr("y1", function(d){
      return (data.nodes[d.source_node].row)*row_height
    })
    .attr("y2", function(d){
      return (data.nodes[d.target_node].row)*row_height
    })
    .style("stroke", "white")
// Create nodes
var node = svg
  .selectAll("nodes")
  .data(data.nodes)
  .enter()
  .append("g")
  .attr("id", function(d){return "node_"+d.name})
  .attr("transform", function(d){return "translate("+(d.col*col_width)+","+(d.row*row_height)+")"})
  .attr("fill", "grey")

var circle = node.append("circle")
    .attr("r", 1.5*row_height)

node.append("text")
  .text(function(d){ return d.name})
  .attr("text-anchor", "middle")
  .attr("dy", 5)
  .style("fill", "white")

// Code for animation

// Define node and link transitions
function node_to_calculating(transition, delay = 1500, wait = 0){
  transition.style("fill", "orange").duration(delay);
}
function node_to_invalidated(transition, delay = 1500, wait = 0){
  transition.style("fill", "grey").duration(delay);
}
function node_to_resting(transition, delay = 1500, wait = 0){
  transition.style("fill", "green").duration(delay);
}

function link_hide(transition, delay = 1500, wait = 0){
  transition.style("stroke", "white").duration(delay);
}
function link_show(transition, delay = 1500, wait = 0){
  transition.style("stroke", "black").duration(delay);
}

function description_show(transition) {
  transition.style("visibility", "visible")
}
function description_hide(transition) {
  transition.style("visibility", "hidden")
}

function button_to_selected(transition) {
  transition.attr("class", "selected-button")
}
function button_to_unselected(transition) {
  transition.attr("class", "unselected-button")
}

// Store object ids as short vars for ease
  var node_a = svg.select("#node_A")
  var node_b = svg.select("#node_B")
  var node_c = svg.select("#node_C")
  var node_d = svg.select("#node_D")
  var node_e = svg.select("#node_E")
  var node_f = svg.select("#node_F")
  var node_g = svg.select("#node_G")
  var node_h = svg.select("#node_H")
  var link_ad = svg.select("#link_0").select("line")
  var link_bd = svg.select("#link_1").select("line")
  var link_be = svg.select("#link_2").select("line")
  var link_cf = svg.select("#link_3").select("line")
  var link_dg = svg.select("#link_4").select("line")
  var link_eh = svg.select("#link_5").select("line")
  var link_fh = svg.select("#link_6").select("line")

  var desc_1 = svg.select("#step_1_desc")
  var desc_2 = svg.select("#step_2_desc")
  var desc_3 = svg.select("#step_3_desc")
  var desc_4 = svg.select("#step_4_desc")
  var desc_5 = svg.select("#step_5_desc")
  var desc_6 = svg.select("#step_6_desc")
  var desc_7 = svg.select("#step_7_desc")
  var desc_8 = svg.select("#step_8_desc")
  var desc_9 = svg.select("#step_9_desc")
  var desc_10 = svg.select("#step_10_desc")
  var desc_11 = svg.select("#step_11_desc")
  var desc_12 = svg.select("#step_12_desc")

  var button_1 = svg.select("#step_1_rect")
  var button_2 = svg.select("#step_2_rect")
  var button_3 = svg.select("#step_3_rect")
  var button_4 = svg.select("#step_4_rect")
  var button_5 = svg.select("#step_5_rect")
  var button_6 = svg.select("#step_6_rect")
  var button_7 = svg.select("#step_7_rect")
  var button_8 = svg.select("#step_8_rect")
  var button_9 = svg.select("#step_9_rect")
  var button_10 = svg.select("#step_10_rect")
  var button_11 = svg.select("#step_11_rect")
  var button_12 = svg.select("#step_12_rect")

// Define animation when Play all is clicked
// Play all
svg.select("#run_all").on("click", function() {
  svg.select("#step_1").dispatch("click", {detail: {run_all_flag: true}})

  repeat();

    function repeat() {
      svg.select("#run_all_rect")
        .transition()
        .attr('class', "flashing-button-first")
        .duration(500)
        .transition()
        .attr('class', "flashing-button-second")
        .duration(500)
        .on("end", repeat);
    };

})

// Define animation when each step is clicked
// Step 1
svg.select("#step_1").on("click", function(d, i) {

  // Node transitions
  node_a.transition().call(node_to_resting, delay = 1000)
  node_b.transition().call(node_to_resting, delay = 1000)
  node_c.transition().call(node_to_resting, delay = 1000)

  node_d.transition().call(node_to_invalidated, delay = 500)
  node_e.transition().call(node_to_invalidated, delay = 500)
  node_f.transition().call(node_to_invalidated, delay = 500)
  node_g.transition().call(node_to_invalidated, delay = 500)
  node_h.transition().call(node_to_invalidated, delay = 500)

  // Link transitions
  link_ad.transition().call(link_hide, delay = 500)
  link_bd.transition().call(link_hide, delay = 500)
  link_be.transition().call(link_hide, delay = 500)
  link_cf.transition().call(link_hide, delay = 500)
  link_dg.transition().call(link_hide, delay = 500)
  link_eh.transition().call(link_hide, delay = 500)
  link_fh.transition().call(link_hide, delay = 500)

  // Description transitions
  desc_1.transition().call(description_show)
  desc_2.transition().call(description_hide)
  desc_3.transition().call(description_hide)
  desc_4.transition().call(description_hide)
  desc_5.transition().call(description_hide)
  desc_6.transition().call(description_hide)
  desc_7.transition().call(description_hide)
  desc_8.transition().call(description_hide)
  desc_9.transition().call(description_hide)
  desc_10.transition().call(description_hide)
  desc_11.transition().call(description_hide)
  desc_12.transition().call(description_hide)

  // Button transitions
  button_1.transition().call(button_to_selected)
  button_2.transition().call(button_to_unselected)
  button_3.transition().call(button_to_unselected)
  button_4.transition().call(button_to_unselected)
  button_5.transition().call(button_to_unselected)
  button_6.transition().call(button_to_unselected)
  button_7.transition().call(button_to_unselected)
  button_8.transition().call(button_to_unselected)
  button_9.transition().call(button_to_unselected)
  button_10.transition().call(button_to_unselected)
  button_11.transition().call(button_to_unselected)
  button_12.transition().call(button_to_unselected)

  // Automatic transition if running through all (use fake transition for delay)
  var running_all = d.detail.run_all_flag
  if (running_all) {
    svg.select("#step_1").transition().attr("visibility","visible").duration(3000).on("end", function(d, i){svg.select("#step_2").dispatch("click", {detail: {run_all_flag: true}})})
  } else {
    // Stop existing transitions and deselect run all
    svg.select("#step_1").transition()
    svg.select("#run_all_rect").transition().attr("class", "unselected-button")
  }

});

// Step 2
svg.select("#step_2").on("click", function(d, i) {

  // Node transitions
  node_a.transition().call(node_to_resting, delay = 500)
  node_b.transition().call(node_to_resting, delay = 500)
  node_c.transition().call(node_to_resting, delay = 500)

  node_d.transition().call(node_to_invalidated, delay = 500)
  node_e.transition().call(node_to_invalidated, delay = 500)
  node_f.transition().call(node_to_invalidated, delay = 500)
  node_g.transition().call(node_to_invalidated, delay = 500)
  node_h.transition().call(node_to_invalidated, delay = 500) // H starts invalidated
  node_h.transition().call(node_to_calculating) // Then becomes calculating

  // Link transitions
  link_ad.transition().call(link_hide, delay = 500)
  link_bd.transition().call(link_hide, delay = 500)
  link_be.transition().call(link_hide, delay = 500)
  link_cf.transition().call(link_hide, delay = 500)
  link_dg.transition().call(link_hide, delay = 500)
  link_eh.transition().call(link_hide, delay = 500)
  link_fh.transition().call(link_hide, delay = 500)

    // Description transitions
  desc_1.transition().call(description_hide)
  desc_2.transition().call(description_show)
  desc_3.transition().call(description_hide)
  desc_4.transition().call(description_hide)
  desc_5.transition().call(description_hide)
  desc_6.transition().call(description_hide)
  desc_7.transition().call(description_hide)
  desc_8.transition().call(description_hide)
  desc_9.transition().call(description_hide)
  desc_10.transition().call(description_hide)
  desc_11.transition().call(description_hide)
  desc_12.transition().call(description_hide)


  // Button transitions
  button_1.transition().call(button_to_unselected)
  button_2.transition().call(button_to_selected)
  button_3.transition().call(button_to_unselected)
  button_4.transition().call(button_to_unselected)
  button_5.transition().call(button_to_unselected)
  button_6.transition().call(button_to_unselected)
  button_7.transition().call(button_to_unselected)
  button_8.transition().call(button_to_unselected)
  button_9.transition().call(button_to_unselected)
  button_10.transition().call(button_to_unselected)
  button_11.transition().call(button_to_unselected)
  button_12.transition().call(button_to_unselected)

  // Automatic transition if running through all (use fake transition for delay)
  var running_all = d.detail.run_all_flag
  if (running_all) {
    svg.select("#step_1").transition().attr("visibility","visible").duration(3000).on("end", function(d, i){svg.select("#step_3").dispatch("click", {detail: {run_all_flag: true}})})
  } else {
    // Stop existing transitions and deselect run all
    svg.select("#step_1").transition()
    svg.select("#run_all_rect").transition().attr("class", "unselected-button")
  }
});

// Step 3
svg.select("#step_3").on("click", function(d, i) {

  // Node transitions
  node_a.transition().call(node_to_resting, delay = 500)
  node_b.transition().call(node_to_resting, delay = 500)
  node_c.transition().call(node_to_resting, delay = 500)

  node_d.transition().call(node_to_invalidated, delay = 500)
  node_e.transition().call(node_to_invalidated, delay = 500) // E starts invalidated
  node_e.transition().call(node_to_calculating).delay(1000) // Then becomes calculating, after a delay
  node_f.transition().call(node_to_invalidated, delay = 500)
  node_g.transition().call(node_to_invalidated, delay = 500)
  node_h.transition().call(node_to_calculating, delay = 500)

  // Link transitions
  link_ad.transition().call(link_hide, delay = 500)
  link_bd.transition().call(link_hide, delay = 500)
  link_be.transition().call(link_hide, delay = 500)
  link_cf.transition().call(link_hide, delay = 500)
  link_dg.transition().call(link_hide, delay = 500)
  link_eh.transition().call(link_hide, delay = 500) // Link E-H starts hidden
  link_eh.transition().call(link_show) // Then becomes visible
  link_fh.transition().call(link_hide, delay = 500)

  // Description transitions
  desc_1.transition().call(description_hide)
  desc_2.transition().call(description_hide)
  desc_3.transition().call(description_show)
  desc_4.transition().call(description_hide)
  desc_5.transition().call(description_hide)
  desc_6.transition().call(description_hide)
  desc_7.transition().call(description_hide)
  desc_8.transition().call(description_hide)
  desc_9.transition().call(description_hide)
  desc_10.transition().call(description_hide)
  desc_11.transition().call(description_hide)
  desc_12.transition().call(description_hide)


  // Button transitions
  button_1.transition().call(button_to_unselected)
  button_2.transition().call(button_to_unselected)
  button_3.transition().call(button_to_selected)
  button_4.transition().call(button_to_unselected)
  button_5.transition().call(button_to_unselected)
  button_6.transition().call(button_to_unselected)
  button_7.transition().call(button_to_unselected)
  button_8.transition().call(button_to_unselected)
  button_9.transition().call(button_to_unselected)
  button_10.transition().call(button_to_unselected)
  button_11.transition().call(button_to_unselected)
  button_12.transition().call(button_to_unselected)

  // Automatic transition if running through all (use fake transition for delay)
  var running_all = d.detail.run_all_flag
  if (running_all) {
    svg.select("#step_1").transition().attr("visibility","visible").duration(3000).on("end", function(d, i){svg.select("#step_4").dispatch("click", {detail: {run_all_flag: true}})})
  } else {
    // Stop existing transitions and deselect run all
    svg.select("#step_1").transition()
    svg.select("#run_all_rect").transition().attr("class", "unselected-button")
  }

});

// Step 4
svg.select("#step_4").on("click", function(d, i) {

  // Node transitions
  node_a.transition().call(node_to_resting, delay = 500)
  node_b.transition().call(node_to_resting, delay = 500)
  node_c.transition().call(node_to_resting, delay = 500)

  node_d.transition().call(node_to_invalidated, delay = 500)
  node_e.transition().call(node_to_calculating, delay = 500) // E starts as calculating
  node_e.transition().call(node_to_resting).delay(1000) // Then E becomes resting after a delay
  node_f.transition().call(node_to_invalidated, delay = 500)
  node_g.transition().call(node_to_invalidated, delay = 500)
  node_h.transition().call(node_to_calculating, delay = 500)

  // Link transitions
  link_ad.transition().call(link_hide, delay = 500)
  link_bd.transition().call(link_hide, delay = 500)
  link_be.transition().call(link_hide, delay = 500) // Link B-E starts hidden
  link_be.transition().call(link_show) // Then becomes visible
  link_cf.transition().call(link_hide, delay = 500)
  link_dg.transition().call(link_hide, delay = 500)
  link_eh.transition().call(link_show, delay = 500)
  link_fh.transition().call(link_hide, delay = 500)

  // Description transitions
  desc_1.transition().call(description_hide)
  desc_2.transition().call(description_hide)
  desc_3.transition().call(description_hide)
  desc_4.transition().call(description_show)
  desc_5.transition().call(description_hide)
  desc_6.transition().call(description_hide)
  desc_7.transition().call(description_hide)
  desc_8.transition().call(description_hide)
  desc_9.transition().call(description_hide)
  desc_10.transition().call(description_hide)
  desc_11.transition().call(description_hide)
  desc_12.transition().call(description_hide)


  // Button transitions
  button_1.transition().call(button_to_unselected)
  button_2.transition().call(button_to_unselected)
  button_3.transition().call(button_to_unselected)
  button_4.transition().call(button_to_selected)
  button_5.transition().call(button_to_unselected)
  button_6.transition().call(button_to_unselected)
  button_7.transition().call(button_to_unselected)
  button_8.transition().call(button_to_unselected)
  button_9.transition().call(button_to_unselected)
  button_10.transition().call(button_to_unselected)
  button_11.transition().call(button_to_unselected)
  button_12.transition().call(button_to_unselected)

  // Automatic transition if running through all (use fake transition for delay)
  var running_all = d.detail.run_all_flag
  if (running_all) {
    svg.select("#step_1").transition().attr("visibility","visible").duration(3000).on("end", function(d, i){svg.select("#step_5").dispatch("click", {detail: {run_all_flag: true}})})
  } else {
    // Stop existing transitions and deselect run all
    svg.select("#step_1").transition()
    svg.select("#run_all_rect").transition().attr("class", "unselected-button")
  }
});

// Step 5
svg.select("#step_5").on("click", function(d, i) {

  // Node transitions
  node_a.transition().call(node_to_resting, delay = 500)
  node_b.transition().call(node_to_resting, delay = 500)
  node_c.transition().call(node_to_resting, delay = 500)

  node_d.transition().call(node_to_invalidated, delay = 500)
  node_e.transition().call(node_to_resting, delay = 500)
  node_f.transition().call(node_to_invalidated, delay = 500) // F starts invalidated
  node_f.transition().call(node_to_calculating).delay(1000) // Then becomes calculating after a delay
  node_g.transition().call(node_to_invalidated, delay = 500)
  node_h.transition().call(node_to_calculating, delay = 500)

  // Link transitions
  link_ad.transition().call(link_hide, delay = 500)
  link_bd.transition().call(link_hide, delay = 500)
  link_be.transition().call(link_show, delay = 500)
  link_cf.transition().call(link_hide, delay = 500)
  link_dg.transition().call(link_hide, delay = 500)
  link_eh.transition().call(link_show, delay = 500)
  link_fh.transition().call(link_hide, delay = 500) // Link F-H starts hidden
  link_fh.transition().call(link_show) // Then becomes visible

  // Description transitions
  desc_1.transition().call(description_hide)
  desc_2.transition().call(description_hide)
  desc_3.transition().call(description_hide)
  desc_4.transition().call(description_hide)
  desc_5.transition().call(description_show)
  desc_6.transition().call(description_hide)
  desc_7.transition().call(description_hide)
  desc_8.transition().call(description_hide)
  desc_9.transition().call(description_hide)
  desc_10.transition().call(description_hide)
  desc_11.transition().call(description_hide)
  desc_12.transition().call(description_hide)


  // Button transitions
  button_1.transition().call(button_to_unselected)
  button_2.transition().call(button_to_unselected)
  button_3.transition().call(button_to_unselected)
  button_4.transition().call(button_to_unselected)
  button_5.transition().call(button_to_selected)
  button_6.transition().call(button_to_unselected)
  button_7.transition().call(button_to_unselected)
  button_8.transition().call(button_to_unselected)
  button_9.transition().call(button_to_unselected)
  button_10.transition().call(button_to_unselected)
  button_11.transition().call(button_to_unselected)
  button_12.transition().call(button_to_unselected)

  // Automatic transition if running through all (use fake transition for delay)
  var running_all = d.detail.run_all_flag
  if (running_all) {
    svg.select("#step_1").transition().attr("visibility","visible").duration(3000).on("end", function(d, i){svg.select("#step_6").dispatch("click", {detail: {run_all_flag: true}})})
  } else {
    // Stop existing transitions and deselect run all
    svg.select("#step_1").transition()
    svg.select("#run_all_rect").transition().attr("class", "unselected-button")
  }
});

// Step 6
svg.select("#step_6").on("click", function(d, i) {

  // Node transitions
  node_a.transition().call(node_to_resting, delay = 500)
  node_b.transition().call(node_to_resting, delay = 500)
  node_c.transition().call(node_to_resting, delay = 500)

  node_d.transition().call(node_to_invalidated, delay = 500)
  node_e.transition().call(node_to_resting, delay = 500)
  node_f.transition().call(node_to_calculating, delay = 500) // F starts calculating
  node_f.transition().call(node_to_resting).delay(1000) // Then becomes resting after a delay
  node_g.transition().call(node_to_invalidated, delay = 500)
  node_h.transition().call(node_to_calculating, delay = 500) // H starts calculating
  node_h.transition().call(node_to_resting).delay(2000) // Then becomes resting, after a delay

  // Link transitions
  link_ad.transition().call(link_hide, delay = 500)
  link_bd.transition().call(link_hide, delay = 500)
  link_be.transition().call(link_show, delay = 500)
  link_cf.transition().call(link_hide, delay = 500) // Link C-f starts hidden
  link_cf.transition().call(link_show) // Then becomes visible
  link_dg.transition().call(link_hide, delay = 500)
  link_eh.transition().call(link_show, delay = 500)
  link_fh.transition().call(link_show, delay = 500)

  // Description transitions
  desc_1.transition().call(description_hide)
  desc_2.transition().call(description_hide)
  desc_3.transition().call(description_hide)
  desc_4.transition().call(description_hide)
  desc_5.transition().call(description_hide)
  desc_6.transition().call(description_show)
  desc_7.transition().call(description_hide)
  desc_8.transition().call(description_hide)
  desc_9.transition().call(description_hide)
  desc_10.transition().call(description_hide)
  desc_11.transition().call(description_hide)
  desc_12.transition().call(description_hide)


  // Button transitions
  button_1.transition().call(button_to_unselected)
  button_2.transition().call(button_to_unselected)
  button_3.transition().call(button_to_unselected)
  button_4.transition().call(button_to_unselected)
  button_5.transition().call(button_to_unselected)
  button_6.transition().call(button_to_selected)
  button_7.transition().call(button_to_unselected)
  button_8.transition().call(button_to_unselected)
  button_9.transition().call(button_to_unselected)
  button_10.transition().call(button_to_unselected)
  button_11.transition().call(button_to_unselected)
  button_12.transition().call(button_to_unselected)

  // Automatic transition if running through all (use fake transition for delay)
  var running_all = d.detail.run_all_flag
  if (running_all) {
    svg.select("#step_1").transition().attr("visibility","visible").duration(5000).on("end", function(d, i){svg.select("#step_7").dispatch("click", {detail: {run_all_flag: true}})})
  } else {
    // Stop existing transitions and deselect run all
    svg.select("#step_1").transition()
    svg.select("#run_all_rect").transition().attr("class", "unselected-button")
  }
});

// Step 7
svg.select("#step_7").on("click", function(d, i) {

  // Node transitions
  node_a.transition().call(node_to_resting, delay = 500)
  node_b.transition().call(node_to_resting, delay = 500)
  node_c.transition().call(node_to_resting, delay = 500)

  node_d.transition().call(node_to_invalidated, delay = 500) // D starts invalidated
  node_d.transition().call(node_to_calculating).delay(1000) // Then becomes calculating
  node_d.transition().call(node_to_resting).delay(2500) // Then finally becomes resting after a delay
  node_e.transition().call(node_to_resting, delay = 500)
  node_f.transition().call(node_to_resting, delay = 500)
  node_g.transition().call(node_to_invalidated, delay = 500) // G starts invalidated
  node_g.transition().call(node_to_calculating)// Then becomes calculating at the start
  node_g.transition().call(node_to_resting).delay(3000) // And becomes resting at the end
  node_h.transition().call(node_to_resting, delay = 500)

  // Link transitions
  link_ad.transition().call(link_hide, delay = 500) // Link A-D starts hidden
  link_ad.transition().call(link_show).delay(1500) // Then becomes visible
  link_bd.transition().call(link_hide, delay = 500) // Link B-D starts hidden
  link_bd.transition().call(link_show).delay(2000) // Then becomes visible
  link_be.transition().call(link_show, delay = 500)
  link_cf.transition().call(link_show, delay = 500)
  link_dg.transition().call(link_hide, delay = 500) // Link D-G starts hidden
  link_dg.transition().call(link_show).delay(500) // Then becomes visible
  link_eh.transition().call(link_show, delay = 500)
  link_fh.transition().call(link_show, delay = 500)

  // Description transitions
  desc_1.transition().call(description_hide)
  desc_2.transition().call(description_hide)
  desc_3.transition().call(description_hide)
  desc_4.transition().call(description_hide)
  desc_5.transition().call(description_hide)
  desc_6.transition().call(description_hide)
  desc_7.transition().call(description_show)
  desc_8.transition().call(description_hide)
  desc_9.transition().call(description_hide)
  desc_10.transition().call(description_hide)
  desc_11.transition().call(description_hide)
  desc_12.transition().call(description_hide)


  // Button transitions
  button_1.transition().call(button_to_unselected)
  button_2.transition().call(button_to_unselected)
  button_3.transition().call(button_to_unselected)
  button_4.transition().call(button_to_unselected)
  button_5.transition().call(button_to_unselected)
  button_6.transition().call(button_to_unselected)
  button_7.transition().call(button_to_selected)
  button_8.transition().call(button_to_unselected)
  button_9.transition().call(button_to_unselected)
  button_10.transition().call(button_to_unselected)
  button_11.transition().call(button_to_unselected)
  button_12.transition().call(button_to_unselected)

  // Automatic transition if running through all (use fake transition for delay)
  var running_all = d.detail.run_all_flag
  if (running_all) {
    svg.select("#step_1").transition().attr("visibility","visible").duration(5000).on("end", function(d, i){svg.select("#step_8").dispatch("click", {detail: {run_all_flag: true}})})
  } else {
    // Stop existing transitions and deselect run all
    svg.select("#step_1").transition()
    svg.select("#run_all_rect").transition().attr("class", "unselected-button")
  }
});

// Step 8
svg.select("#step_8").on("click", function(d, i) {

  // Node transitions
  node_a.transition().call(node_to_resting, delay = 500)
  node_b.transition().call(node_to_resting, delay = 500) // B starts resting
  node_b.transition().call(node_to_invalidated) // Then becomes invalidated
  node_c.transition().call(node_to_resting, delay = 500)

  node_d.transition().call(node_to_resting, delay = 500)
  node_e.transition().call(node_to_resting, delay = 500)
  node_f.transition().call(node_to_resting, delay = 500)
  node_g.transition().call(node_to_resting, delay = 500)
  node_h.transition().call(node_to_resting, delay = 500)

  // Link transitions
  link_ad.transition().call(link_show, delay = 500)
  link_bd.transition().call(link_show, delay = 500)
  link_be.transition().call(link_show, delay = 500)
  link_cf.transition().call(link_show, delay = 500)
  link_dg.transition().call(link_show, delay = 500)
  link_eh.transition().call(link_show, delay = 500)
  link_fh.transition().call(link_show, delay = 500)

  // Description transitions
  desc_1.transition().call(description_hide)
  desc_2.transition().call(description_hide)
  desc_3.transition().call(description_hide)
  desc_4.transition().call(description_hide)
  desc_5.transition().call(description_hide)
  desc_6.transition().call(description_hide)
  desc_7.transition().call(description_hide)
  desc_8.transition().call(description_show)
  desc_9.transition().call(description_hide)
  desc_10.transition().call(description_hide)
  desc_11.transition().call(description_hide)
  desc_12.transition().call(description_hide)


  // Button transitions
  button_1.transition().call(button_to_unselected)
  button_2.transition().call(button_to_unselected)
  button_3.transition().call(button_to_unselected)
  button_4.transition().call(button_to_unselected)
  button_5.transition().call(button_to_unselected)
  button_6.transition().call(button_to_unselected)
  button_7.transition().call(button_to_unselected)
  button_8.transition().call(button_to_selected)
  button_9.transition().call(button_to_unselected)
  button_10.transition().call(button_to_unselected)
  button_11.transition().call(button_to_unselected)
  button_12.transition().call(button_to_unselected)

  // Automatic transition if running through all (use fake transition for delay)
  var running_all = d.detail.run_all_flag
  if (running_all) {
    svg.select("#step_1").transition().attr("visibility","visible").duration(3000).on("end", function(d, i){svg.select("#step_9").dispatch("click", {detail: {run_all_flag: true}})})
  } else {
    // Stop existing transitions and deselect run all
    svg.select("#step_1").transition()
    svg.select("#run_all_rect").transition().attr("class", "unselected-button")
  }
});

// Step 9
svg.select("#step_9").on("click", function(d, i) {

  // Node transitions
  node_a.transition().call(node_to_resting, delay = 500)
  node_b.transition().call(node_to_invalidated, delay = 500)
  node_c.transition().call(node_to_resting, delay = 500)

  node_d.transition().call(node_to_resting, delay = 500) // D starts resting
  node_d.transition().call(node_to_invalidated) // Then becomes invalidated
  node_e.transition().call(node_to_resting, delay = 500) // E starts resting
  node_e.transition().call(node_to_invalidated) // Then becomes invalidated
  node_f.transition().call(node_to_resting, delay = 500)
  node_g.transition().call(node_to_resting, delay = 500) // G starts resting
  node_g.transition().call(node_to_invalidated).delay(1500) // Then becomes invalidated, after a delay
  node_h.transition().call(node_to_resting, delay = 500) // H starts resting
  node_h.transition().call(node_to_invalidated).delay(1500) // Then becomes invalidated, after a delay

  // Link transitions
  link_ad.transition().call(link_show, delay = 500)
  link_bd.transition().call(link_show, delay = 500)
  link_be.transition().call(link_show, delay = 500)
  link_cf.transition().call(link_show, delay = 500)
  link_dg.transition().call(link_show, delay = 500)
  link_eh.transition().call(link_show, delay = 500)
  link_fh.transition().call(link_show, delay = 500)

  // Description transitions
  desc_1.transition().call(description_hide)
  desc_2.transition().call(description_hide)
  desc_3.transition().call(description_hide)
  desc_4.transition().call(description_hide)
  desc_5.transition().call(description_hide)
  desc_6.transition().call(description_hide)
  desc_7.transition().call(description_hide)
  desc_8.transition().call(description_hide)
  desc_9.transition().call(description_show)
  desc_10.transition().call(description_hide)
  desc_11.transition().call(description_hide)
  desc_12.transition().call(description_hide)


  // Button transitions
  button_1.transition().call(button_to_unselected)
  button_2.transition().call(button_to_unselected)
  button_3.transition().call(button_to_unselected)
  button_4.transition().call(button_to_unselected)
  button_5.transition().call(button_to_unselected)
  button_6.transition().call(button_to_unselected)
  button_7.transition().call(button_to_unselected)
  button_8.transition().call(button_to_unselected)
  button_9.transition().call(button_to_selected)
  button_10.transition().call(button_to_unselected)
  button_11.transition().call(button_to_unselected)
  button_12.transition().call(button_to_unselected)

  // Automatic transition if running through all (use fake transition for delay)
  var running_all = d.detail.run_all_flag
  if (running_all) {
    svg.select("#step_1").transition().attr("visibility","visible").duration(5000).on("end", function(d, i){svg.select("#step_10").dispatch("click", {detail: {run_all_flag: true}})})
  } else {
    // Stop existing transitions and deselect run all
    svg.select("#step_1").transition()
    svg.select("#run_all_rect").transition().attr("class", "unselected-button")
  }
});

// Step 10
svg.select("#step_10").on("click", function(d, i) {

  // Node transitions
  node_a.transition().call(node_to_resting, delay = 500)
  node_b.transition().call(node_to_invalidated, delay = 500) // B starts invalidated
  node_b.transition().call(node_to_resting).delay(2000) // Then becomes resting
  node_c.transition().call(node_to_resting, delay = 500)

  node_d.transition().call(node_to_invalidated, delay = 500)
  node_e.transition().call(node_to_invalidated, delay = 500)
  node_f.transition().call(node_to_resting, delay = 500)
  node_g.transition().call(node_to_invalidated, delay = 500)
  node_h.transition().call(node_to_invalidated, delay = 500)

  // Link transitions
  link_ad.transition().call(link_show, delay = 500) // Link A-D starts visible
  link_ad.transition().call(link_hide) // Then becomes hidden
  link_bd.transition().call(link_show, delay = 500) // Link B-D starts visible
  link_bd.transition().call(link_hide) // Then becomes hidden
  link_be.transition().call(link_show, delay = 500) // Link B-E starts visible
  link_be.transition().call(link_hide) // Then becomes hidden
  link_cf.transition().call(link_show, delay = 500)
  link_dg.transition().call(link_show, delay = 500) // Link D-G starts visible
  link_dg.transition().call(link_hide).delay(1500) // Then becomes hidden, after a delay
  link_eh.transition().call(link_show, delay = 500) // Link E-H starts visible
  link_eh.transition().call(link_hide).delay(1500) // Then becomes hidden, after a delay
  link_fh.transition().call(link_show, delay = 500) // Link F-H starts visible
  link_fh.transition().call(link_hide).delay(1500) // Then becomes hidden, after a delay

  // Description transitions
  desc_1.transition().call(description_hide)
  desc_2.transition().call(description_hide)
  desc_3.transition().call(description_hide)
  desc_4.transition().call(description_hide)
  desc_5.transition().call(description_hide)
  desc_6.transition().call(description_hide)
  desc_7.transition().call(description_hide)
  desc_8.transition().call(description_hide)
  desc_9.transition().call(description_hide)
  desc_10.transition().call(description_show)
  desc_11.transition().call(description_hide)
  desc_12.transition().call(description_hide)


  // Button transitions
  button_1.transition().call(button_to_unselected)
  button_2.transition().call(button_to_unselected)
  button_3.transition().call(button_to_unselected)
  button_4.transition().call(button_to_unselected)
  button_5.transition().call(button_to_unselected)
  button_6.transition().call(button_to_unselected)
  button_7.transition().call(button_to_unselected)
  button_8.transition().call(button_to_unselected)
  button_9.transition().call(button_to_unselected)
  button_10.transition().call(button_to_selected)
  button_11.transition().call(button_to_unselected)
  button_12.transition().call(button_to_unselected)

  // Automatic transition if running through all (use fake transition for delay)
  var running_all = d.detail.run_all_flag
  if (running_all) {
    svg.select("#step_1").transition().attr("visibility","visible").duration(3000).on("end", function(d, i){svg.select("#step_11").dispatch("click", {detail: {run_all_flag: true}})})
  } else {
    // Stop existing transitions and deselect run all
    svg.select("#step_1").transition()
    svg.select("#run_all_rect").transition().attr("class", "unselected-button")
  }
});

// Step 11
svg.select("#step_11").on("click", function(d, i) {

  // Node transitions
  node_a.transition().call(node_to_resting, delay = 500)
  node_b.transition().call(node_to_resting, delay = 500)
  node_c.transition().call(node_to_resting, delay = 500)

  node_d.transition().call(node_to_invalidated, delay = 500)
  node_e.transition().call(node_to_invalidated, delay = 500)
  node_f.transition().call(node_to_resting, delay = 500)
  node_g.transition().call(node_to_invalidated, delay = 500) // G starts invalidated
  node_g.transition().call(node_to_calculating) // Then becomes calculating
  node_h.transition().call(node_to_invalidated, delay = 500)

  // Link transitions
  link_ad.transition().call(link_hide, delay = 500)
  link_bd.transition().call(link_hide, delay = 500)
  link_be.transition().call(link_hide, delay = 500)
  link_cf.transition().call(link_show, delay = 500)
  link_dg.transition().call(link_hide, delay = 500)
  link_eh.transition().call(link_hide, delay = 500)
  link_fh.transition().call(link_hide, delay = 500)

  // Description transitions
  desc_1.transition().call(description_hide)
  desc_2.transition().call(description_hide)
  desc_3.transition().call(description_hide)
  desc_4.transition().call(description_hide)
  desc_5.transition().call(description_hide)
  desc_6.transition().call(description_hide)
  desc_7.transition().call(description_hide)
  desc_8.transition().call(description_hide)
  desc_9.transition().call(description_hide)
  desc_10.transition().call(description_hide)
  desc_11.transition().call(description_show)
  desc_12.transition().call(description_hide)


  // Button transitions
  button_1.transition().call(button_to_unselected)
  button_2.transition().call(button_to_unselected)
  button_3.transition().call(button_to_unselected)
  button_4.transition().call(button_to_unselected)
  button_5.transition().call(button_to_unselected)
  button_6.transition().call(button_to_unselected)
  button_7.transition().call(button_to_unselected)
  button_8.transition().call(button_to_unselected)
  button_9.transition().call(button_to_unselected)
  button_10.transition().call(button_to_unselected)
  button_11.transition().call(button_to_selected)
  button_12.transition().call(button_to_unselected)

  // Automatic transition if running through all (use fake transition for delay)
  var running_all = d.detail.run_all_flag
  if (running_all) {
    svg.select("#step_1").transition().attr("visibility","visible").duration(3000).on("end", function(d, i){svg.select("#step_12").dispatch("click", {detail: {run_all_flag: true}})})
  } else {
    // Stop existing transitions and deselect run all
    svg.select("#step_1").transition()
    svg.select("#run_all_rect").transition().attr("class", "unselected-button")
  }
});

// Step 12
svg.select("#step_12").on("click", function(d, i) {

  // Node transitions
  node_a.transition().call(node_to_resting, delay = 500)
  node_b.transition().call(node_to_resting, delay = 500)
  node_c.transition().call(node_to_resting, delay = 500)

  node_d.transition().call(node_to_invalidated, delay = 500) // D starts invalidated
  node_d.transition().call(node_to_calculating).delay(300) // Then becomes calculating
  node_d.transition().call(node_to_resting).delay(2000) // Then becomes resting
  node_e.transition().call(node_to_invalidated, delay = 500) // E starts invalidated
  node_e.transition().call(node_to_calculating).delay(4500) // Then becomes calculating
  node_e.transition().call(node_to_resting).delay(5500) // And finally becomes resting
  node_f.transition().call(node_to_resting, delay = 500)
  node_g.transition().call(node_to_calculating, delay = 500) // G starts calculating
  node_g.transition().call(node_to_resting).delay(2500) // Then becomes resting
  node_h.transition().call(node_to_invalidated, delay = 500) // H starts invalidated
  node_h.transition().call(node_to_calculating).delay(3000) // Then becomes calculating
  node_h.transition().call(node_to_resting).delay(6000) // And finally becomes resting

  // Link transitions
  link_ad.transition().call(link_hide, delay = 500) // Link A-D starts hidden
  link_ad.transition().call(link_show).delay(1000) // Then becomes visible
  link_bd.transition().call(link_hide, delay = 500) // Link B-D starts hidden
  link_bd.transition().call(link_show).delay(1500) // Then becomes visible
  link_be.transition().call(link_hide, delay = 500) // Link B-E starts hidden
  link_be.transition().call(link_show).delay(5000) // Then becomes visible
  link_cf.transition().call(link_show, delay = 500)
  link_dg.transition().call(link_hide, delay = 500) // Link D-G starts hidden
  link_dg.transition().call(link_show) // Then becomes visible
  link_eh.transition().call(link_hide, delay = 500) // Link E-H starts hidden
  link_eh.transition().call(link_show).delay(4000) // Then becomes visible
  link_fh.transition().call(link_hide, delay = 500) // Link F-H starts hidden
  link_fh.transition().call(link_show).delay(3500) // Then becomes visible

  // Description transitions
  desc_1.transition().call(description_hide)
  desc_2.transition().call(description_hide)
  desc_3.transition().call(description_hide)
  desc_4.transition().call(description_hide)
  desc_5.transition().call(description_hide)
  desc_6.transition().call(description_hide)
  desc_7.transition().call(description_hide)
  desc_8.transition().call(description_hide)
  desc_9.transition().call(description_hide)
  desc_10.transition().call(description_hide)
  desc_11.transition().call(description_hide)
  desc_12.transition().call(description_show)


  // Button transitions
  button_1.transition().call(button_to_unselected)
  button_2.transition().call(button_to_unselected)
  button_3.transition().call(button_to_unselected)
  button_4.transition().call(button_to_unselected)
  button_5.transition().call(button_to_unselected)
  button_6.transition().call(button_to_unselected)
  button_7.transition().call(button_to_unselected)
  button_8.transition().call(button_to_unselected)
  button_9.transition().call(button_to_unselected)
  button_10.transition().call(button_to_unselected)
  button_11.transition().call(button_to_unselected)
  button_12.transition().call(button_to_selected)

  // Automatic transition if running through all (use fake transition for delay)
  // No more steps
    // Stop existing transitions and deselect run all
    svg.select("#step_1").transition()
    svg.select("#run_all_rect").transition().attr("class", "unselected-button")

});
