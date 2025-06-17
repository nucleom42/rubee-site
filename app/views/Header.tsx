import React from "react";

export default function Header() {
  return (
      <header>
        <nav className="navbar">
          <div className="nav-group">
            <a href="#why">Why Rubee?</a>
            <a href="#docs">Docs</a>
          </div>
          <div className="logo">
            <img src="images/rubee.svg" alt="rubee"/>
          </div>
          <div className="nav-group">
            <a href="#community">Community</a>
            <a href="#github">GitHub</a>
          </div>
        </nav>

        <div className="hero">
          <h1>Rubee</h1>
          <p>Fast and lightweight Ruby application server designed for minimalism and flexibility.</p>
        </div>
      </header>
  );
}
