package service

import (
	"context"
	"time"

	"github.com/omkar273/nashikdarshan/internal/api/dto"
	ierr "github.com/omkar273/nashikdarshan/internal/errors"
	"github.com/omkar273/nashikdarshan/internal/types"
)

type PlaceService interface {
	// Core operations
	Create(ctx context.Context, req *dto.CreatePlaceRequest) (*dto.PlaceResponse, error)
	Get(ctx context.Context, id string) (*dto.PlaceResponse, error)
	GetBySlug(ctx context.Context, slug string) (*dto.PlaceResponse, error)
	Update(ctx context.Context, id string, req *dto.UpdatePlaceRequest) (*dto.PlaceResponse, error)
	Delete(ctx context.Context, id string) error

	// List operations
	List(ctx context.Context, filter *types.PlaceFilter) (*dto.ListPlacesResponse, error)

	// Image operations
	AddImage(ctx context.Context, placeID string, req *dto.CreatePlaceImageRequest) (*dto.PlaceImageResponse, error)
	GetImages(ctx context.Context, placeID string) ([]*dto.PlaceImageResponse, error)
	UpdateImage(ctx context.Context, imageID string, req *dto.UpdatePlaceImageRequest) (*dto.PlaceImageResponse, error)
	DeleteImage(ctx context.Context, imageID string) error

	// Feed operations
	GetFeed(ctx context.Context, req *dto.FeedRequest) (*dto.FeedResponse, error)
	IncrementViewCount(ctx context.Context, placeID string) error
	UpdatePopularityScores(ctx context.Context) error

	// Category operations
	AssignCategories(ctx context.Context, placeID string, req *dto.AssignCategoriesRequest) error
}

type placeService struct {
	ServiceParams
}

// NewPlaceService creates a new place service
func NewPlaceService(params ServiceParams) PlaceService {
	return &placeService{
		ServiceParams: params,
	}
}

// Create creates a new place
func (s *placeService) Create(ctx context.Context, req *dto.CreatePlaceRequest) (*dto.PlaceResponse, error) {
	if err := req.Validate(); err != nil {
		return nil, err
	}

	p, err := req.ToPlace(ctx)
	if err != nil {
		return nil, err
	}

	err = s.PlaceRepo.Create(ctx, p)
	if err != nil {
		return nil, err
	}

	return dto.NewPlaceResponse(p), nil
}

// Get retrieves a place by ID
func (s *placeService) Get(ctx context.Context, id string) (*dto.PlaceResponse, error) {
	p, err := s.PlaceRepo.Get(ctx, id)
	if err != nil {
		return nil, err
	}

	return dto.NewPlaceResponse(p), nil
}

// GetBySlug retrieves a place by slug
func (s *placeService) GetBySlug(ctx context.Context, slug string) (*dto.PlaceResponse, error) {
	p, err := s.PlaceRepo.GetBySlug(ctx, slug)
	if err != nil {
		return nil, err
	}

	return dto.NewPlaceResponse(p), nil
}

// Update updates an existing place
func (s *placeService) Update(ctx context.Context, id string, req *dto.UpdatePlaceRequest) (*dto.PlaceResponse, error) {
	if err := req.Validate(); err != nil {
		return nil, err
	}

	p, err := s.PlaceRepo.Get(ctx, id)
	if err != nil {
		return nil, err
	}

	err = req.ApplyToPlace(ctx, p)
	if err != nil {
		return nil, err
	}

	err = s.PlaceRepo.Update(ctx, p)
	if err != nil {
		return nil, err
	}

	// Fetch the updated place to get all fields
	updatedPlace, err := s.PlaceRepo.Get(ctx, id)
	if err != nil {
		return nil, err
	}

	return dto.NewPlaceResponse(updatedPlace), nil
}

// Delete soft deletes a place
func (s *placeService) Delete(ctx context.Context, id string) error {
	p, err := s.PlaceRepo.Get(ctx, id)
	if err != nil {
		return err
	}

	return s.PlaceRepo.Delete(ctx, p)
}

// List retrieves a paginated list of places
func (s *placeService) List(ctx context.Context, filter *types.PlaceFilter) (*dto.ListPlacesResponse, error) {
	if filter == nil {
		filter = types.NewPlaceFilter()
	}

	// Get places
	places, err := s.PlaceRepo.List(ctx, filter)
	if err != nil {
		return nil, err
	}

	// Get total count
	total, err := s.PlaceRepo.Count(ctx, filter)
	if err != nil {
		return nil, err
	}

	// Create paginated response using DTO helper
	limit := filter.GetLimit()
	offset := filter.GetOffset()
	response := dto.NewListPlacesResponse(places, total, limit, offset)

	return response, nil
}

// AddImage adds an image to a place
func (s *placeService) AddImage(ctx context.Context, placeID string, req *dto.CreatePlaceImageRequest) (*dto.PlaceImageResponse, error) {
	if err := req.Validate(); err != nil {
		return nil, err
	}

	// Verify place exists
	_, err := s.PlaceRepo.Get(ctx, placeID)
	if err != nil {
		return nil, err
	}

	image := req.ToPlaceImage(ctx, placeID)

	err = s.PlaceRepo.AddImage(ctx, image)
	if err != nil {
		return nil, err
	}

	// Fetch the created image
	images, err := s.PlaceRepo.GetImages(ctx, placeID)
	if err != nil {
		return nil, err
	}

	// Find the newly created image
	for _, img := range images {
		if img.ID == image.ID {
			return &dto.PlaceImageResponse{PlaceImage: img}, nil
		}
	}

	return &dto.PlaceImageResponse{PlaceImage: image}, nil
}

// GetImages retrieves all images for a place
func (s *placeService) GetImages(ctx context.Context, placeID string) ([]*dto.PlaceImageResponse, error) {
	// Verify place exists
	_, err := s.PlaceRepo.Get(ctx, placeID)
	if err != nil {
		return nil, err
	}

	images, err := s.PlaceRepo.GetImages(ctx, placeID)
	if err != nil {
		return nil, err
	}

	// Convert to DTO responses
	responses := make([]*dto.PlaceImageResponse, len(images))
	for i, img := range images {
		responses[i] = &dto.PlaceImageResponse{PlaceImage: img}
	}

	return responses, nil
}

// UpdateImage updates an existing place image
func (s *placeService) UpdateImage(ctx context.Context, imageID string, req *dto.UpdatePlaceImageRequest) (*dto.PlaceImageResponse, error) {
	if err := req.Validate(); err != nil {
		return nil, err
	}

	// Get the existing image
	image, err := s.PlaceRepo.GetImage(ctx, imageID)
	if err != nil {
		return nil, err
	}

	req.ApplyToPlaceImage(ctx, image)

	err = s.PlaceRepo.UpdateImage(ctx, image)
	if err != nil {
		return nil, err
	}

	// Fetch the updated image
	updatedImage, err := s.PlaceRepo.GetImage(ctx, imageID)
	if err != nil {
		return nil, err
	}

	return &dto.PlaceImageResponse{PlaceImage: updatedImage}, nil
}

// DeleteImage deletes a place image
func (s *placeService) DeleteImage(ctx context.Context, imageID string) error {
	return s.PlaceRepo.DeleteImage(ctx, imageID)
}

// GetFeed retrieves feed data for multiple sections
func (s *placeService) GetFeed(ctx context.Context, req *dto.FeedRequest) (*dto.FeedResponse, error) {
	if err := req.Validate(); err != nil {
		return nil, err
	}

	sections := make([]dto.FeedSectionResponse, 0, len(req.Sections))

	// Process each section request
	for _, sectionReq := range req.Sections {
		sectionResponse, err := s.processSectionRequest(ctx, sectionReq, req)
		if err != nil {
			// Log error but continue with other sections (graceful degradation)
			s.Logger.Errorw("failed to process section",
				"section_type", sectionReq.Type,
				"error", err)
			continue
		}

		sections = append(sections, sectionResponse)
	}

	return dto.NewFeedResponse(sections), nil
}

// processSectionRequest handles a single section request
func (s *placeService) processSectionRequest(ctx context.Context, sectionReq dto.FeedSectionRequest, globalReq *dto.FeedRequest) (dto.FeedSectionResponse, error) {
	// Create base filter from request
	filter := sectionReq.ToPlaceFilter(globalReq)

	// Apply section-specific filter modifications
	switch sectionReq.Type {
	case types.SectionTypeLatest:
		// Latest uses default sorting (by created_at desc)
	case types.SectionTypeTrending:
		// Add trending-specific time filter (48 hours lookback for last viewed)
		cutoffTime := time.Now().UTC().Add(-48 * time.Hour)
		filter.LastViewedAfter = &cutoffTime
	case types.SectionTypePopular:
		// Popular uses default sorting (by popularity_score desc)
	case types.SectionTypeNearby:
		// Nearby uses geospatial filtering (already handled in ToPlaceFilter)
	default:
		return dto.FeedSectionResponse{}, ierr.NewError("unsupported section type").
			WithHint("Please use a valid section type").
			Mark(ierr.ErrValidation)
	}

	// Execute the common List + Count pattern
	places, err := s.PlaceRepo.List(ctx, filter)
	if err != nil {
		return dto.FeedSectionResponse{}, err
	}

	total, err := s.PlaceRepo.Count(ctx, filter)
	if err != nil {
		return dto.FeedSectionResponse{}, err
	}

	return dto.NewFeedSectionResponseFromDomain(
		sectionReq.Type,
		places,
		total,
		filter.GetLimit(),
		filter.GetOffset(),
	), nil
}

// IncrementViewCount increments the view count for a place
func (s *placeService) IncrementViewCount(ctx context.Context, placeID string) error {
	// Verify place exists
	_, err := s.PlaceRepo.Get(ctx, placeID)
	if err != nil {
		return err
	}

	// Increment view count
	return s.PlaceRepo.IncrementViewCount(ctx, placeID)
}

// UpdatePopularityScores recalculates popularity scores for all places
func (s *placeService) UpdatePopularityScores(ctx context.Context) error {
	s.Logger.Infow("starting popularity score update")

	// Get all places (no limit)
	filter := types.NewNoLimitPlaceFilter()
	places, err := s.PlaceRepo.ListAll(ctx, filter)
	if err != nil {
		return err
	}

	// Calculate and update popularity score for each place
	for _, place := range places {
		score := place.CalculatePopularityScore()
		err = s.PlaceRepo.UpdatePopularityScore(ctx, place.ID, score)
		if err != nil {
			s.Logger.Errorw("failed to update popularity score", "place_id", place.ID, "error", err)
			return err
		}
	}

	s.Logger.Infow("completed popularity score update", "places_updated", len(places))
	return nil
}

// AssignCategories assigns categories to a place
func (s *placeService) AssignCategories(ctx context.Context, placeID string, req *dto.AssignCategoriesRequest) error {
	if err := req.Validate(); err != nil {
		return err
	}

	// Verify place exists
	_, err := s.PlaceRepo.Get(ctx, placeID)
	if err != nil {
		return err
	}

	err = s.PlaceRepo.AssignCategories(ctx, placeID, req.CategoryIDs)
	if err != nil {
		return err
	}

	return nil
}
