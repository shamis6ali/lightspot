const express = require('express');
const router = express.Router();
const { body, validationResult } = require('express-validator');

// Validation middleware
const validateSpot = [
  body('name').trim().isLength({ min: 2, max: 100 }),
  body('description').trim().isLength({ min: 10, max: 1000 }),
  body('latitude').isFloat({ min: -90, max: 90 }),
  body('longitude').isFloat({ min: -180, max: 180 })
];

// Get all spots with pagination
router.get('/', async (req, res) => {
  try {
    const { page = 1, limit = 20, lat, lng, radius } = req.query;
    
    // TODO: Implement actual database query with filtering
    // For now, return mock data
    const mockSpots = [
      {
        id: '1',
        name: 'Central Park',
        description: 'Beautiful urban park in the heart of the city',
        latitude: 40.7829,
        longitude: -73.9654,
        createdBy: 'user1',
        createdAt: new Date().toISOString()
      },
      {
        id: '2',
        name: 'Brooklyn Bridge',
        description: 'Iconic bridge connecting Manhattan and Brooklyn',
        latitude: 40.7061,
        longitude: -73.9969,
        createdBy: 'user2',
        createdAt: new Date().toISOString()
      }
    ];

    res.json({
      success: true,
      data: mockSpots,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total: mockSpots.length,
        hasNext: false,
        hasPrev: false
      }
    });
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch spots', message: error.message });
  }
});

// Get spot by ID
router.get('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    
    // TODO: Implement actual database query
    const mockSpot = {
      id: id,
      name: 'Central Park',
      description: 'Beautiful urban park in the heart of the city',
      latitude: 40.7829,
      longitude: -73.9969,
      createdBy: 'user1',
      createdAt: new Date().toISOString()
    };

    res.json({
      success: true,
      data: mockSpot
    });
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch spot', message: error.message });
  }
});

// Create new spot
router.post('/', validateSpot, async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { name, description, latitude, longitude } = req.body;
    
    // TODO: Implement actual database insertion
    const newSpot = {
      id: Date.now().toString(),
      name,
      description,
      latitude: parseFloat(latitude),
      longitude: parseFloat(longitude),
      createdBy: 'user1', // TODO: Get from auth middleware
      createdAt: new Date().toISOString()
    };

    res.status(201).json({
      success: true,
      data: newSpot,
      message: 'Spot created successfully'
    });
  } catch (error) {
    res.status(500).json({ error: 'Failed to create spot', message: error.message });
  }
});

// Update spot
router.put('/:id', validateSpot, async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { id } = req.params;
    const { name, description, latitude, longitude } = req.body;
    
    // TODO: Implement actual database update
    const updatedSpot = {
      id,
      name,
      description,
      latitude: parseFloat(latitude),
      longitude: parseFloat(longitude),
      createdBy: 'user1',
      updatedAt: new Date().toISOString()
    };

    res.json({
      success: true,
      data: updatedSpot,
      message: 'Spot updated successfully'
    });
  } catch (error) {
    res.status(500).json({ error: 'Failed to update spot', message: error.message });
  }
});

// Delete spot
router.delete('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    
    // TODO: Implement actual database deletion
    
    res.json({
      success: true,
      message: 'Spot deleted successfully'
    });
  } catch (error) {
    res.status(500).json({ error: 'Failed to delete spot', message: error.message });
  }
});

module.exports = router;
