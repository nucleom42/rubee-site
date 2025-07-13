import React from "react";
import { useState, useEffect } from 'react';
import Header from "./Header";
import Footer from "./Footer";

export default function Docs() {
  const [sections, setSections] = useState([]);
  useEffect(() => {
    fetch('/api/sections')
      .then(response => response.json())
      .then(data => setSections(data));
  }, [setSections]);
  return (
    <>
      <Header />
      <main>
        <h2 id="why">All about Rubee</h2>
        <div className="features">
          {sections.map(section => (
            <div key={section.id} className="feature">
              <h3>{section.title}</h3>
              <p>{section.description}</p>
            </div>
          ))}
        </div>
      </main>
      <Footer />
    </>
  );
}
