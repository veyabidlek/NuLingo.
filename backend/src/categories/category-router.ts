import { Router } from "express";
import fs from "fs";
import path from "path";

const categoryRouter = Router();

categoryRouter.get("/activity", (req, res) => {
  const filePath = path.join(__dirname, "../../data/activity.json");
  fs.readFile(filePath, "utf-8", (err, data) => {
    if (err) {
      return res.status(500).json({ error: "Failed to read the file" });
    }
    try {
      const jsonData = JSON.parse(data);
      return res.json(jsonData);
    } catch (parseError) {
      return res.status(500).json({ error: "Failed to parse JSON" });
    }
  });
});

categoryRouter.get("/family", (req, res) => {
  const filePath = path.join(__dirname, "../../data/family.json");
  fs.readFile(filePath, "utf-8", (err, data) => {
    if (err) {
      return res.status(500).json({ error: "Failed to read the file" });
    }
    try {
      const jsonData = JSON.parse(data);
      return res.json(jsonData);
    } catch (parseError) {
      return res.status(500).json({ error: "Failed to parse JSON" });
    }
  });
});

categoryRouter.get("/finance", (req, res) => {
  const filePath = path.join(__dirname, "../../data/finance.json");
  fs.readFile(filePath, "utf-8", (err, data) => {
    if (err) {
      return res.status(500).json({ error: "Failed to read the file" });
    }
    try {
      const jsonData = JSON.parse(data);
      return res.json(jsonData);
    } catch (parseError) {
      return res.status(500).json({ error: "Failed to parse JSON" });
    }
  });
});

categoryRouter.get("/food", (req, res) => {
  const filePath = path.join(__dirname, "../../data/food.json");
  fs.readFile(filePath, "utf-8", (err, data) => {
    if (err) {
      return res.status(500).json({ error: "Failed to read the file" });
    }
    try {
      const jsonData = JSON.parse(data);
      return res.json(jsonData);
    } catch (parseError) {
      return res.status(500).json({ error: "Failed to parse JSON" });
    }
  });
});

categoryRouter.get("/religion", (req, res) => {
  const filePath = path.join(__dirname, "../../data/religion.json");
  fs.readFile(filePath, "utf-8", (err, data) => {
    if (err) {
      return res.status(500).json({ error: "Failed to read the file" });
    }
    try {
      const jsonData = JSON.parse(data);
      return res.json(jsonData);
    } catch (parseError) {
      return res.status(500).json({ error: "Failed to parse JSON" });
    }
  });
});

categoryRouter.get("/technology", (req, res) => {
  const filePath = path.join(__dirname, "../../data/technology.json");
  fs.readFile(filePath, "utf-8", (err, data) => {
    if (err) {
      return res.status(500).json({ error: "Failed to read the file" });
    }
    try {
      const jsonData = JSON.parse(data);
      return res.json(jsonData);
    } catch (parseError) {
      return res.status(500).json({ error: "Failed to parse JSON" });
    }
  });
});

categoryRouter.get("/sport", (req, res) => {
  const filePath = path.join(__dirname, "../../data/sport.json");
  fs.readFile(filePath, "utf-8", (err, data) => {
    if (err) {
      return res.status(500).json({ error: "Failed to read the file" });
    }
    try {
      const jsonData = JSON.parse(data);
      return res.json(jsonData);
    } catch (parseError) {
      return res.status(500).json({ error: "Failed to parse JSON" });
    }
  });
});

categoryRouter.get("/drinks", (req, res) => {
  const filePath = path.join(__dirname, "../../data/drinks.json");
  fs.readFile(filePath, "utf-8", (err, data) => {
    if (err) {
      return res.status(500).json({ error: "Failed to read the file" });
    }
    try {
      const jsonData = JSON.parse(data);
      return res.json(jsonData);
    } catch (parseError) {
      return res.status(500).json({ error: "Failed to parse JSON" });
    }
  });
});

categoryRouter.get("/animals", (req, res) => {
  const filePath = path.join(__dirname, "../../data/animals.json");
  fs.readFile(filePath, "utf-8", (err, data) => {
    if (err) {
      return res.status(500).json({ error: "Failed to read the file" });
    }
    try {
      const jsonData = JSON.parse(data);
      return res.json(jsonData);
    } catch (parseError) {
      return res.status(500).json({ error: "Failed to parse JSON" });
    }
  });
});

export default categoryRouter;
