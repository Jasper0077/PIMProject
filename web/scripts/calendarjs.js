function openTitleForm(){

}

function changeDpColor()
{
  let choice = document.getElementById('colorSelect');
  if (choice.value =='#007acc') {
    displayBlue();
  }
  else if (choice.value == 'green') {
    displayGreen();
  }
  else if (choice.value == '#cc0000') {
    displayRed();
  }
  else if (choice.value == 'purple') {
    displayPurple();
  }
  else if (choice.value == '#e65c00') {
    displayOrange();
  }
  else if (choice.value == 'maroon') {
    displayMaroon();
  }
  else if (choice.value == 'grey') {
      displayGrey();
  }
  else if (choice.value == 'black') {
    displayBlack();
  }
  else if (choice.value == '#ff33bb') {
    displayPink();
  }

}
function changeEditDpColor()
{
  let choice = document.getElementById('colorEdit');
  if (choice.value =='#007acc') {
    displayBlue();
  }
  else if (choice.value == 'green') {
    displayGreen();
  }
  else if (choice.value == '#cc0000') {
    displayRed();
  }
  else if (choice.value == 'purple') {
    displayPurple();
  }
  else if (choice.value == '#e65c00') {
    displayOrange();
  }
  else if (choice.value == 'maroon') {
    displayMaroon();
  }
  else if (choice.value == 'grey') {
      displayGrey();
  }
  else if (choice.value == 'black') {
    displayBlack();
  }
  else if (choice.value == '#ff33bb') {
    displayPink();
  }

}
function displayBlue(){
  document.getElementById('colorSelectDisplay').style.backgroundColor = '#007acc';
  document.getElementById('colorEditDisplay').style.backgroundColor = '#007acc';
}

function displayGreen(){
  document.getElementById('colorSelectDisplay').style.backgroundColor = 'green';
  document.getElementById('colorEditDisplay').style.backgroundColor = 'green';
}

function displayRed(){
  document.getElementById('colorSelectDisplay').style.backgroundColor = '#cc0000';
  document.getElementById('colorEditDisplay').style.backgroundColor = '#cc0000';
}

function displayPurple(){
  document.getElementById('colorSelectDisplay').style.backgroundColor = 'purple';
  document.getElementById('colorEditDisplay').style.backgroundColor = 'purple';
}

function displayOrange(){
  document.getElementById('colorSelectDisplay').style.backgroundColor = '#e65c00';
  document.getElementById('colorEditDisplay').style.backgroundColor = '#e65c00';
}

function displayMaroon(){
  document.getElementById('colorSelectDisplay').style.backgroundColor = 'maroon';
  document.getElementById('colorEditDisplay').style.backgroundColor = 'maroon';
}

function displayGrey(){
  document.getElementById('colorSelectDisplay').style.backgroundColor = 'grey';
  document.getElementById('colorEditDisplay').style.backgroundColor = 'grey';
}

function displayBlack(){
  document.getElementById('colorSelectDisplay').style.backgroundColor = 'black';
  document.getElementById('colorEditDisplay').style.backgroundColor = 'black';
}

function displayPink(){
  document.getElementById('colorSelectDisplay').style.backgroundColor = '#ff33bb';
  document.getElementById('colorEditDisplay').style.backgroundColor = '#ff33bb';
}

function validateEvent()
{
  let y = document.getElementById('001').value;
  if (y == "") {
    alert("Title cannot be blank");
    return false;
  }

}

function validateEditEvent()
{
  let y = document.getElementById('002').value;
  if (y == "") {
    alert("Title cannot be blank");
    return false;
  }

}

function show() {
  let backContainer = document.getElementById('backContainer');
  backContainer.style.display = "block";

}

function unShow() {
  let backContainer = document.getElementById('backContainer');
  let backContainer1 = document.getElementById('eventEorD-Container');
  let backContainer2 = document.getElementById('edit-event-name');
  backContainer.style.display = "none";
  backContainer1.style.display = "none";
  backContainer2.style.display = "none";
}

function showAction()
{
  let backContainer = document.getElementById('eventEorD-Container');
  backContainer.style.display = "block";
}

function showEdit()
{
  let backContainer = document.getElementById('edit-event-name');
  backContainer.style.display = "block";
  let backContainer1 = document.getElementById('eventEorD-Container');
  backContainer1.style.display = "none";
}

function showDelete()
{
  document.getElementById('delete-confirm-container').style.display = 'block';
}

window.onclick = function(event) {
  let backContainer = document.getElementById('backContainer');
  if (event.target == backContainer)
  {
    backContainer.style.display = "none";
  }

  let backContainer1 = document.getElementById('eventEorD-Container');
  if (event.target == backContainer1)
  {
    backContainer1.style.display = "none";
  }

  let backContainer2 = document.getElementById('edit-event-name');
  if (event.target == backContainer2)
  {
    backContainer2.style.display = "none";
  }
}
