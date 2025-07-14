import React from "react";
import { Link } from 'react-router-dom';

export default function Header() {
  return (
      <header>
        <nav className="navbar">
          <div className="nav-group">
            <Link to="/#why">Why Rubee?</Link>
            <Link to="/docs">Docs</Link>
          </div>
          <div className="logo">
            <Link to="/"><img src="/images/rubee.svg" alt="rubee"/></Link>
          </div>
          <div className="nav-group">
            <a href="https://github.com/nucleom42/rubee/discussions">Community</a>
            <a href="https://github.com/nucleom42/rubee">GitHub</a>
          </div>
        </nav>

        <div className="hero">
          <h1>Rubee</h1>
          <p>Fast and lightweight Ruby application server designed for minimalism and flexibility.</p>
        </div>
      </header>
  );
}
