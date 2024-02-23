const BEERS = {};
const BREWERIES = {};

const handleResponse = (beers) => {
  BEERS.list = beers;
  BEERS.show();
};

const handleBreweryResponse = (breweries) => {
  BREWERIES.list = breweries;
  BREWERIES.show();
};

const createTableRow = (beer) => {
  const tr = document.createElement("tr");
  tr.classList.add("tablerow");
  const beername = tr.appendChild(document.createElement("td"));
  beername.innerHTML = beer.name;
  const style = tr.appendChild(document.createElement("td"));
  style.innerHTML = beer.style.name;
  const brewery = tr.appendChild(document.createElement("td"));
  brewery.innerHTML = beer.brewery.name;

  return tr;
};

const createBreweryTableRow = (brewery) => {
  const tr = document.createElement("tr");
  tr.classList.add("tablerow");
  const breweryname = tr.appendChild(document.createElement("td"));
  breweryname.innerHTML = brewery.name;
  const year = tr.appendChild(document.createElement("td"));
  year.innerHTML = brewery.year;
  const beer_count = tr.appendChild(document.createElement("td"));
  // beer_count.innerHTML = Object.keys(brewery.beers).length;
  beer_count.innerHTML = brewery.beers.count;
  const active = tr.appendChild(document.createElement("td"));
  active.innerHTML = !!brewery.active ? 'Active' : 'Retired';

  return tr;
};

BEERS.show = () => {
  document.querySelectorAll(".tablerow").forEach((el) => el.remove());
  const table = document.getElementById("beertable");

  BEERS.list.forEach((beer) => {
    const tr = createTableRow(beer);
    table.appendChild(tr);
  });
};

BREWERIES.show = () => {
  document.querySelectorAll(".tablerow").forEach((el) => el.remove());
  const table = document.getElementById("brewerytable");

  BREWERIES.list.forEach((beer) => {
    const tr = createBreweryTableRow(beer);
    table.appendChild(tr);
  });
};

BEERS.sortByName = () => {
  BEERS.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BREWERIES.sortByName = () => {
  BREWERIES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BEERS.sortByStyle = () => {
  BEERS.list.sort((a, b) => {
    return a.style.name.toUpperCase().localeCompare(b.style.name.toUpperCase());
  });
};

BEERS.sortByBrewery = () => {
  BEERS.list.sort((a, b) => {
    return a.brewery.name
      .toUpperCase()
      .localeCompare(b.brewery.name.toUpperCase());
  });
};

BREWERIES.sortByYear = () => {
  BREWERIES.list.sort((a, b) => {
    return a.year - b.year;
  });
};

BREWERIES.sortByBeers = () => {
  BREWERIES.list.sort((a, b) => {
    return b.beers.count - a.beers.count;
  });
};

BREWERIES.sortByActive = () => {
  BREWERIES.list.sort((a, b) => {
    return (a.active === b.active)? 0: a.active? -1 : 1;
  });
};

const beers = () => {
  if (document.querySelectorAll("#beertable").length < 1) return;

  document.getElementById("name").addEventListener("click", (e) => {
    e.preventDefault;
    BEERS.sortByName();
    BEERS.show();
  });

  document.getElementById("style").addEventListener("click", (e) => {
    e.preventDefault;
    BEERS.sortByStyle();
    BEERS.show();
  });

  document.getElementById("brewery").addEventListener("click", (e) => {
    e.preventDefault;
    BEERS.sortByBrewery();
    BEERS.show();
  });

  fetch("beers.json")
    .then((response) => response.json())
    .then(handleResponse);


  //   var request = new XMLHttpRequest();

  // request.onload = handleResponse;

  // request.open("get", "beers.json", true);
  // request.send();
};

// const handleBrewResponse = (breweries) => {
//   // document.getElementById("breweries").innerText = `panimoita löytyi ${data.length}`;
//   const breweryList = breweries.map((brewery) => `<li>${brewery.name}</li>`);

//   document.getElementById("breweries").innerHTML = `<ul> ${breweryList.join("")} </ul>`;
// };

// const createBrewTableRow = (brew) => {
//   const tr = document.createElement("tr");
//   const brewname = tr.appendChild(document.createElement("td"));
//   brewname.innerHTML = brew.name;

//   return tr;
// };


const breweries = () => {
  if (document.querySelectorAll("#brewerytable").length < 1) return;

  document.getElementById("name").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByName();
    BREWERIES.show();
  });

  document.getElementById("est").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByYear();
    BREWERIES.show();
  });

  document.getElementById("beers").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByBeers();
    BREWERIES.show();
  });

  document.getElementById("active").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByActive();
    BREWERIES.show();
  });

  fetch("breweries.json")
    .then((response) => response.json())
    .then(handleBreweryResponse);
  // document.getElementById("breweries").innerText = "Hello from JavaScript";
  console.log("hello console, breweries done!");
};

// export { hello };
export { beers, breweries };
