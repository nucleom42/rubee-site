import React, { useEffect, useState  } from "react";
import { Link } from "react-router-dom";

export default function SearchResults() {
  const [searchResults, setSearchResults] = useState([]);
  const [query, setQuery] = useState("");

  const handleSearch = (e) => {
    e.preventDefault();
    if (query.trim()) {
      fetch(`/api/documents/search/${query}`)
        .then((response) => response.json())
        .then((data) => {
          setSearchResults(data);
        })
        .catch((error) => {
          console.error("Error searching:", error);
        });
    }
  };
  return (
    <>
    <form className="search-bar" onSubmit={handleSearch}>
          <input type="text"
              placeholder="Search documents..."
              value={query}
              onChange={(e) => setQuery(e.target.value)}
          />
          <button type="submit">Search</button>
    </form>
    <div className="search-results">
      {searchResults.length === 0 ? (
        <p></p>
      ) : (
        <ul>
          {searchResults.map((doc) => (
            <li key={doc.id}>
              <Link to={`/documents/${doc.id}`}>{doc.title}</Link>
            </li>
          ))}
        </ul>
      )}
    </div>
    </>
  );
}
