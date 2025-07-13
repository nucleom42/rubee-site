import React from "react";
import { BrowserRouter as Router, Routes, Route, Link } from "react-router-dom";
import "./../../css/app.css";
import Main from "./Main";
import Docs from "./Docs";
import Document from "./Document";

const NotFound = () => <h2>404 Not Found</h2>;

export function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Main />} />
        <Route path="/docs" element={<Docs />} />
        <Route path="*" element={<NotFound />} />
        <Route path="/documents/:id" element={<Document />} />
      </Routes>
    </Router>
  );
}

