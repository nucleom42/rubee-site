import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";

export default function Header({ title }) {
  const navigate = useNavigate();
  const [menuOpen, setMenuOpen] = useState(false);
  const [news, setNews] = useState([]);
  const [newsOpen, setNewsOpen] = useState(true);

  useEffect(() => {
    const titleElement = document.getElementById("title-content");
    if (titleElement) {
      document.title = `Rubee - ${titleElement.textContent || "a minimalistic Ruby application server"}`;
    }
  }, [title]);

  useEffect(() => {
    if (title) return;
    // Fetch news documents from the "news" section
    fetch("/api/sections/3/documents")
      .then((res) => res.json())
      .then((data) => setNews(data))
      .catch((err) => console.error("Failed to fetch news:", err));
  }, [setNews, title]);

  return (
    <header>
      <div hidden id="title-content">{title}</div>
      <nav className="navbar">
        <button
          className="hamburger"
          onClick={() => setMenuOpen(!menuOpen)}
          aria-label="Toggle menu"
        >
          {menuOpen ? "-" : "☰"}
        </button>

        <div className={`nav-group ${menuOpen ? "open" : ""}`}>
          <Link to="/sections/2/documents" onClick={() => setMenuOpen(false)}>How to Rubee</Link>
          <Link to="/docs" onClick={() => setMenuOpen(false)}>Docs</Link>
          <a href="https://github.com/nucleom42/rubee/discussions" onClick={() => setMenuOpen(false)}>Community</a>
          <a href="https://github.com/nucleom42/rubee" onClick={() => setMenuOpen(false)}>GitHub</a>
        </div>

        <div className="logo">
          <Link to="/"><img src="/images/rubee.svg" alt="rubee" /></Link>
        </div>
      </nav>

      <div className="hero">
        <h1>Rubee</h1>
        {title ? (
          <>
            <h2>{title}</h2>
            <button onClick={() => navigate(-1)}>← Back</button>
          </>
        ) : (
          <>
          <p>
            Fast and lightweight Ruby web framework designed for minimalism and flexibility.
          </p>
          {(news.length > 0 && newsOpen) && (
          <div className="news-feed">
            <button className="news-close" onClick={() => setNewsOpen(false)}>×</button>
            <h3>ru.Bee news</h3>
            {news.length > 0 ? (
              <ul>
                {news.slice(-3).map((item) => (
                  <li key={item.id}>
                    <Link to={`/documents/${item.id}`}>{item.title}</Link>
                    <span className="news-date">{new Date(item.replace(" ", "T").created).toLocaleDateString()}</span>
                  </li>
                ))}
              </ul>
            ) : (
              <p>No news available.</p>
            )}
          </div>
          )}
          </>
        )}
      </div>

    </header>
  );
}
