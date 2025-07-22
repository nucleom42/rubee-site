import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";

export default function Header({ title }) {
  const navigate = useNavigate();
  const [menuOpen, setMenuOpen] = useState(false);

  return (
    <header>
      <nav className="navbar">
        <button
          className="hamburger"
          onClick={() => setMenuOpen(!menuOpen)}
          aria-label="Toggle menu"
        >
          {menuOpen ? "✖" : "☰"}
        </button>

        <div className={`nav-group ${menuOpen ? "open" : ""}`}>
          <Link to="/sections/3/documents" onClick={() => setMenuOpen(false)}>How to RUBEE</Link>
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
          <p>
            Fast and lightweight Ruby application server designed for minimalism and flexibility.
          </p>
        )}
      </div>
    </header>
  );
}
